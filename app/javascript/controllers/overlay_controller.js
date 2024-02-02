import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="overlay"
export default class extends Controller {
  static targets = ["overlay", "modal"];

  toggle() {
    this.overlayTarget.classList.remove("hidden");
    this.overlayTarget.classList.add("flex");
    this.modalTarget.classList.remove("hidden");
    this.modalTarget.classList.add("grid");
  }

  closeModal() {
    this.overlayTarget.classList.add("hidden");
    this.overlayTarget.classList.remove("flex");
    this.modalTarget.classList.remove("grid");
    this.modalTarget.classList.add("hidden");
  }

  closeOnCodeInput() {
    // Ajoutez ici la logique pour valider le code d'inscription
    // et fermer l'overlay si le code est correct.
  }
}
