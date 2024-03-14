import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="group"
export default class extends Controller {
  static targets = ["form", "icon"];

  connect() {
    // Initialiser avec le formulaire non visible et non interactif
    this.formTarget.classList.add("hidden");
    this.formTarget.classList.add("translate-y-[-100%]");

    this.isOpen = false;
  }

  toggle() {
    if (this.isOpen) {
      // Commencer l'animation de fermeture
      this.formTarget.classList.replace("translate-y-0", "translate-y-[-100%]");

      // Attendre que l'animation soit terminée pour cacher complètement le formulaire
      setTimeout(() => {
        this.formTarget.classList.add("hidden");
      }, 150); // Correspond à la durée de l'animation

      this.iconTarget.classList.replace("fa-chevron-up", "fa-chevron-down");
    } else {
      // Rendre le formulaire visible pour l'animation
      this.formTarget.classList.remove("hidden");

      // Assurer un délai pour permettre la transition CSS
      setTimeout(() => {
        this.formTarget.classList.replace("translate-y-[-100%]", "translate-y-0");
      }, 10); // Un petit délai pour que la transition soit appliquée correctement

      this.iconTarget.classList.replace("fa-chevron-down", "fa-chevron-up");
    }

    this.isOpen = !this.isOpen;
  }
}
