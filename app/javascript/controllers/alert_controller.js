import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const dismissAfter = 1000
    setTimeout(() => {
      this.dismiss()
    }, dismissAfter)
  }

  dismiss() {
    this.element.classList.add('animate-fade-out-up')
    setTimeout(() => {
      this.element.remove()
    }, 1000) // Match this with animation duration
  }
} 