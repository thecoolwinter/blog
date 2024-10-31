function navRandom() {
    const navLinks = Array.from(document.head.querySelectorAll('link[data-nav="true"]'))
        .map(link => link.href)
        .filter(link => link !== window.location.href);
    console.log(navLinks)
    if (navLinks.length > 0) {
        const randomNavLink = navLinks[Math.floor(Math.random() * navLinks.length)];
        window.location.href = randomNavLink;
    }
}
