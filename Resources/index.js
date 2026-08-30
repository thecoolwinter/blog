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

document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".phone-embed").forEach(embed => {
        const video = embed.querySelector("video");
        const button = embed.querySelector(".phone-speed");
        if (!video || !button) return;

        const applySpeed = (speed) => {
            video.playbackRate = speed;
            button.dataset.speed = String(speed);
            button.querySelectorAll("span").forEach(span => {
                span.dataset.active = String(parseFloat(span.textContent) === speed);
            });
        };

        const initial = parseFloat(button.dataset.speed);
        applySpeed(Number.isFinite(initial) ? initial : 1);

        button.addEventListener("click", () => {
            applySpeed(parseFloat(button.dataset.speed) === 1 ? 0.5 : 1);
        });
    });
});
