import $ from 'jquery'
import axios from 'axios'

const handleHeartDisplay = (hasLiked) => {
    if (hasLiked) {
        $('.active-heart').removeClass('hidden')
    } else {
        $('.inactive-heart').removeClass('hidden')
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const dataset = $('#post-show').data()
    const postId = dataset.postId

    axios.get(`/posts/${postId}/like`)
        .then((response) => {
            const hasLiked = response.data.hasLiked
            handleHeartDisplay(hasLiked)
        })

    $('.inactive-heart').on('click', () => {
        axios.post(`/posts/${postId}/like`)
          .then((response) => {
            if (response.data.status === 'ok') {
                $('.active-heart').removeClass('hidden')
                $('.inactive-heart').addClass('hidden')
            }
          })
          .catch((e) => {
            window.alert('Error')
            console.log(e)
          })
    })

    $('.active-heart').on('click', () => {
        axios.delete(`/posts/${postId}/like`)
          .then((response) => {
              if (response.data.status === 'ok') {
                  $('.active-heart').addClass('hidden')
                  $('.inactive-heart').removeClass('hidden')
              }
          })
          .catch((e) => {
            window.alert('Error')
            console.log(e)
          })
    })
})