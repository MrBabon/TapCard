import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["alert"];

  connect() {
    this.autoCloseAlert();
  }

  closeAlert() {
    this.alertTarget.style.display = "none";
  }

  autoCloseAlert() {
    setTimeout(() => {
      this.closeAlert();
    }, 3000);
  }
}
