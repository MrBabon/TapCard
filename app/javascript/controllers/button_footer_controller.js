import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="button-footer"
export default class extends Controller {
  static targets = ["icon"];

  connect() {
    const currentURL = window.location.href;
    this.iconTargets.forEach((icon) => {
      const linkURL = icon.parentElement.href;
      if (linkURL === currentURL) {
        icon.classList.add("active");
      }
    });
  }

  disconnect() {
    this.iconTargets.forEach((icon) => {
      icon.classList.remove("active");
    });
  }
}
