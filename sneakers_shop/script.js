// ── Données des produits ──
const products = [
    {
        id: 1,
        name: "Nike TN",
        shortDesc: "L'iconique silhouette rétro-futuriste",
        price: 110,
        image: "images/produit1.jpg",
        description: "Les Nike TN Air Max Plus sont des baskets mythiques des années 90. Leur design aérodynamique et leur silhouette distinctive en font des incontournables. Parfaites pour les amateurs de rétro et de streetwear.",
        colors: ["Blanc", "Noir", "Bleu électrique", "Orange/Noir", "Gris"],
        sizes: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]
    },
    {
        id: 2,
        name: "Nike Vomero 5",
        shortDesc: "Le confort cushioning premium",
        price: 95,
        image: "images/produit2.jpg",
        description: "Les Nike Vomero 5 combinent le style rétro des années 2000 avec une technologie de confort exceptionnelle. Leur semelle cushionée et leur design bombé les rendent parfaites pour le quotidien.",
        colors: ["Blanc", "Noir", "Gris/Blanc", "Bleu", "Rose"],
        sizes: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]
    },
    {
        id: 3,
        name: "Asics Kayano 14",
        shortDesc: "La running performance intemporelle",
        price: 75,
        image: "images/produit3.jpg",
        description: "Les Asics Gel-Kayano 14 sont des chaussures de running emblématiques. Leur technologie Gel et leur stabilité exceptionnelle les rendent idéales pour tous types de coureurs, du casual au professionnel.",
        colors: ["Blanc", "Noir", "Bleu marine", "Rose/Blanc", "Orange"],
        sizes: [35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]
    },
    {
        id: 4,
        name: "New Balance 2002R",
        shortDesc: "L'élégance rétro minimaliste",
        price: 140,
        image: "images/produit4.jpg",
        description: "Les New Balance 2002R allient le style vintage des années 2000 avec du confort moderne. Leur design épuré et leurs couleurs subtiles en font des baskets parfaites pour tous les styles de vie.",
        colors: ["Blanc", "Gris/Blanc", "Noir", "Beige", "Marine"],
        sizes: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]
    },
    {
        id: 5,
        name: "Crocs",
        shortDesc: "Le confort et l'originalité réunis",
        price: 89,
        image: "images/produit5.jpg",
        description: "Les Crocs offrent un confort ultime avec leur design unique en mousse. Légères, aérées et faciles à enfiler, elles sont parfaites pour la plage, la piscine ou le casual quotidien.",
        colors: ["Blanc", "Noir", "Rose fluo", "Bleu électrique", "Orange"],
        sizes: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]
    },
    {
        id: 6,
        name: "Adidas Samba",
        shortDesc: "L'intemporel de la mode et du foot",
        price: 85,
        image: "images/produit6.jpg",
        description: "Les Adidas Samba sont des baskets légendaires créées en 1950 pour les joueurs de football sur gazon. Leur design classique et leur confort intemporel les rendent indispensables dans toute dressing.",
        colors: ["Blanc/Noir", "Blanc", "Noir/Blanc", "Rose/Blanc", "Bleu/Blanc"],
        sizes: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]
    }
];

// ── Variables globales ──
let cart = JSON.parse(localStorage.getItem('cart')) || [];
let currentProduct = null;
let selectedColor = null;
let selectedSize = null;

// ── Hamburger menu ──
const hamburger = document.getElementById('hamburger');
const navLinks = document.getElementById('navLinks');

if (hamburger) {
    hamburger.addEventListener('click', () => {
        navLinks.classList.toggle('open');
    });
}

document.querySelectorAll('.nav-links a').forEach(link => {
    link.addEventListener('click', () => navLinks.classList.remove('open'));
});

// ── Afficher les produits ──
function displayProducts() {
    const productsGrid = document.getElementById('productsGrid');
    productsGrid.innerHTML = products.map(product => `
        <div class="project-card product-card" data-id="${product.id}">
            <img src="${product.image}" alt="${product.name}" style="width:100%; height:200px; object-fit:cover; cursor:pointer;">
            <h3 style="cursor:pointer;">${product.name}</h3>
            <p>${product.shortDesc}</p>
            <span class="project-tag">Prix: ${product.price}€</span>
            <button class="cv-btn add-to-cart">Ajouter au panier</button>
        </div>
    `).join('');

    // Ajouter les événements
    document.querySelectorAll('.product-card').forEach(card => {
        const productId = parseInt(card.dataset.id);

        // Clic sur l'image ou le titre pour afficher le détail
        card.querySelector('img').addEventListener('click', () => showProductDetail(productId));
        card.querySelector('h3').addEventListener('click', () => showProductDetail(productId));

        // Bouton ajouter au panier
        card.querySelector('.add-to-cart').addEventListener('click', (e) => {
            e.stopPropagation();
            const product = products.find(p => p.id === productId);
            addToCart(product.id, product.name, product.price);
        });
    });
}

// ── Afficher le détail du produit ──
function showProductDetail(productId) {
    const product = products.find(p => p.id === productId);
    if (!product) return;

    currentProduct = product;
    selectedColor = product.colors[0];
    selectedSize = product.sizes[Math.floor(product.sizes.length / 2)];

    // Remplir les données
    document.getElementById('detailName').textContent = product.name;
    document.getElementById('detailShortDesc').textContent = product.shortDesc;
    document.getElementById('detailPrice').textContent = product.price + '€';
    document.getElementById('detailImage').src = product.image;
    document.getElementById('detailDescription').textContent = product.description;

    // Afficher les couleurs
    const colorsContainer = document.getElementById('colorsContainer');
    colorsContainer.innerHTML = product.colors.map(color => `
        <div class="color-option ${color === selectedColor ? 'selected' : ''}"
             style="background: ${getColorHex(color)};"
             data-color="${color}"
             title="${color}">
            <span class="color-label">${color}</span>
        </div>
    `).join('');

    document.querySelectorAll('.color-option').forEach(option => {
        option.addEventListener('click', function() {
            document.querySelectorAll('.color-option').forEach(o => o.classList.remove('selected'));
            this.classList.add('selected');
            selectedColor = this.dataset.color;
        });
    });

    // Afficher les tailles
    const sizesContainer = document.getElementById('sizesContainer');
    sizesContainer.innerHTML = product.sizes.map(size => `
        <button class="size-option ${size === selectedSize ? 'selected' : ''}"
                data-size="${size}">
            ${size}
        </button>
    `).join('');

    document.querySelectorAll('.size-option').forEach(option => {
        option.addEventListener('click', function() {
            document.querySelectorAll('.size-option').forEach(o => o.classList.remove('selected'));
            this.classList.add('selected');
            selectedSize = parseInt(this.dataset.size);
        });
    });

    // Bouton ajouter au panier depuis le détail
    document.getElementById('addToDetailCart').addEventListener('click', () => {
        addToCart(product.id, product.name, product.price, selectedColor, selectedSize);
        showNotification(`${product.name} (${selectedSize}, ${selectedColor}) ajouté au panier!`);
        document.getElementById('productDetail').style.display = 'none';
        document.getElementById('produits').scrollIntoView({ behavior: 'smooth' });
    });

    // Afficher la page détail
    document.getElementById('produits').style.display = 'none';
    document.getElementById('product-detail').style.display = 'block';
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

// ── Convertir le nom de couleur en hex ──
function getColorHex(colorName) {
    const colorMap = {
        'Blanc': '#FFFFFF',
        'Noir': '#000000',
        'Marine': '#003366',
        'Bleu marine': '#003366',
        'Rouge': '#E63946',
        'Gris': '#888888',
        'Vert': '#228B22',
        'Rose': '#FFB6C1',
        'Rose fluo': '#FF69B4',
        'Bleu': '#0066CC',
        'Bleu électrique': '#00FFFF',
        'Jaune': '#FFD700',
        'Orange': '#FF8C00',
        'Jaune/Noir': '#FFD700',
        'Gris/Noir': '#888888',
        'Noir/Noir': '#000000',
        'Noir/Rouge': '#E63946',
        'Noir/Blanc': '#000000',
        'Blanc/Marine': '#FFFFFF',
        'Blanc/Noir': '#FFFFFF',
        'Rouge/Noir': '#E63946'
    };
    return colorMap[colorName] || '#666666';
}

// ── Bouton retour ──
document.getElementById('backBtn')?.addEventListener('click', () => {
    document.getElementById('product-detail').style.display = 'none';
    document.getElementById('produits').style.display = 'block';
    window.scrollTo({ top: 0, behavior: 'smooth' });
});

// ── Panier ──
function updateCartBadge() {
    const badge = document.getElementById('cartBadge');
    if (badge) {
        badge.textContent = cart.length;
    }
}

function saveCart() {
    localStorage.setItem('cart', JSON.stringify(cart));
    updateCartBadge();
    updateCartDisplay();
}

function addToCart(id, name, price, color = '', size = '') {
    const itemId = `${id}-${color}-${size}`;
    const existing = cart.find(item => item.itemId === itemId);

    if (existing) {
        existing.quantity += 1;
    } else {
        cart.push({
            itemId: itemId,
            id: parseInt(id),
            name: name,
            price: parseFloat(price),
            color: color,
            size: size,
            quantity: 1
        });
    }

    saveCart();
}

function removeFromCart(itemId) {
    cart = cart.filter(item => item.itemId !== itemId);
    saveCart();
}

function updateQuantity(itemId, quantity) {
    const item = cart.find(item => item.itemId === itemId);
    if (item) {
        item.quantity = Math.max(1, parseInt(quantity));
        saveCart();
    }
}

function updateCartDisplay() {
    const emptyCart = document.getElementById('emptyCart');
    const cartItems = document.getElementById('cartItems');
    const cartBody = document.getElementById('cartBody');

    if (cart.length === 0) {
        emptyCart.style.display = 'block';
        cartItems.style.display = 'none';
    } else {
        emptyCart.style.display = 'none';
        cartItems.style.display = 'block';

        cartBody.innerHTML = '';

        cart.forEach(item => {
            const total = item.price * item.quantity;
            const details = item.color || item.size ? ` (${item.size}€ ${item.color})` : '';
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${item.name}${details}</td>
                <td>${item.price.toFixed(2)}€</td>
                <td>
                    <div class="quantity-control">
                        <button onclick="updateQuantity('${item.itemId}', ${item.quantity - 1})">−</button>
                        <span class="quantity-display">${item.quantity}</span>
                        <button onclick="updateQuantity('${item.itemId}', ${item.quantity + 1})">+</button>
                    </div>
                </td>
                <td>${total.toFixed(2)}€</td>
                <td><button class="remove-btn" onclick="removeFromCart('${item.itemId}')">Supprimer</button></td>
            `;
            cartBody.appendChild(row);
        });

        updateTotals();
    }
}

function updateTotals() {
    const subtotal = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    const total = subtotal;

    const subtotalEl = document.getElementById('subtotal');
    const totalEl = document.getElementById('total');

    if (subtotalEl) subtotalEl.textContent = subtotal.toFixed(2) + '€';
    if (totalEl) totalEl.textContent = total.toFixed(2) + '€';
}

function showNotification(message) {
    const notification = document.createElement('div');
    notification.style.cssText = `
        position: fixed;
        top: 80px;
        right: 20px;
        background: rgba(230, 57, 70, 0.2);
        border: 1px solid #E63946;
        color: #E63946;
        padding: 1rem 1.5rem;
        border-radius: 4px;
        font-family: 'Space Mono', monospace;
        font-size: 0.9rem;
        z-index: 2000;
        animation: slideIn 0.3s ease;
    `;
    notification.textContent = message;
    document.body.appendChild(notification);

    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease';
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}

// ── Contact form ──
const form = document.getElementById('contactForm');
const successMsg = document.getElementById('successMsg');

if (form) {
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        const firstName = document.getElementById('firstName').value;

        successMsg.style.display = 'block';
        showNotification(`Merci ${firstName} ! Nous avons reçu votre message.`);

        this.reset();

        setTimeout(() => { successMsg.style.display = 'none'; }, 5000);
    });
}

// ── Checkout button ──
const checkoutBtn = document.querySelector('.checkout-btn');
if (checkoutBtn) {
    checkoutBtn.addEventListener('click', () => {
        const total = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
        alert(`Commande de ${total.toFixed(2)}€ confirmée! (simulation)`);
        cart = [];
        saveCart();
    });
}

// ── Smooth scroll ──
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (!target) return;

        const targetY = target.offsetTop - 70;
        const currentY = window.pageYOffset;
        const diff = targetY - currentY;
        const duration = 1400;
        let start = null;

        function animate(timestamp) {
            if (!start) start = timestamp;
            const progress = Math.min((timestamp - start) / duration, 1);
            const ease = progress < 0.5
                ? 4 * progress * progress * progress
                : 1 - Math.pow(-2 * progress + 2, 3) / 2;
            window.scrollTo(0, currentY + diff * ease);
            if (progress < 1) requestAnimationFrame(animate);
        }
        requestAnimationFrame(animate);
    });
});

// ── Animation on scroll ──
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, { threshold: 0.1 });

// ── Animation CSS ──
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from { opacity: 0; transform: translateX(100px); }
        to { opacity: 1; transform: translateX(0); }
    }
    @keyframes slideOut {
        from { opacity: 1; transform: translateX(0); }
        to { opacity: 0; transform: translateX(100px); }
    }
`;
document.head.appendChild(style);

// ── Initialiser ──
displayProducts();
updateCartBadge();
updateCartDisplay();

document.querySelectorAll('.project-card, .product-detail').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(20px)';
    el.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
    observer.observe(el);
});
