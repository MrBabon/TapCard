import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preview-image"
export default class extends Controller {
  connect() {
  }
  
  previewImage(event) {
    const input = event.target;
    const previewContainer = document.getElementById("image-preview-container");
    const userAvatar = document.getElementById("user-avatar");

    const previewImage = document.createElement("img");
    previewImage.classList.add("rounded-full", "object-cover", "object-center", "w-16", "h-16", "shadow-md");

    if (input.files && input.files[0]) {
      const reader = new FileReader();

      reader.onload = function (e) {
        userAvatar.src = e.target.result;
        previewContainer.innerHTML = "";
        
      };

      reader.readAsDataURL(input.files[0]);
    }
  }
}
