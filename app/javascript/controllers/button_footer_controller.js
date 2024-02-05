import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="button-footer"
export default class extends Controller {
  static targets = ["icon"];

  connect() {
    const currentURL = window.location.href;
    this.iconTargets.forEach((icon) => {
      const linkURL = icon.parentElement.href;
      if (linkURL === currentURL) {
        icon.classList.remove("text-TapCard-charcoal");
        icon.classList.add("text-TapCard-navy");
      }
    });
  }

  disconnect() {
    this.iconTargets.forEach((icon) => {
      icon.classList.remove("text-TapCard-navy");
      icon.classList.add("text-TapCard-charcoal");
    });
  }
}
