import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["commentList", "commentBody"]

  connect() {
    console.log("Comments controller connected!")
  }

  createSuccess(event) {
    const [_data, _status, xhr] = event.detail

    // Dodaj nowy komentarz na początku listy
    this.commentListTarget.innerHTML = xhr.response + this.commentListTarget.innerHTML
 
    // Wyczyść pole tekstowe (commentBodyTarget)
    this.commentBodyTarget.value = ''
  }

	delete(event) {
	  const commentId = event.target.getAttribute("data-comments-id-param")
	  if (!commentId) return

	  // Wyślij żądanie DELETE na poprawną ścieżkę
	  fetch(`/comments/${commentId}`, {
	    method: "DELETE",
	    headers: { "X-CSRF-Token": document.querySelector("[name='csrf-token']").content }
	  })
	    .then((response) => {
	      if (response.ok) {
	        // Usuń komentarz z listy
	        const commentElement = document.getElementById(`comment-${commentId}`)
	        if (commentElement) commentElement.remove()
	      } else {
	        console.error("Failed to delete the comment.")
	      }
	    })
	}
}
