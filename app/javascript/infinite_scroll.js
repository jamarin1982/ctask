document.addEventListener('DOMContentLoaded', function () {
  var loading = false;
  var pagination = document.getElementById('pagination');
  if (!pagination) return;

  window.addEventListener('scroll', function () {
    if (loading) return;
    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight - 100) {
      var nextLink = pagination.querySelector('a[rel=next]');
      if (nextLink) {
        loading = true;
        fetch(nextLink.href, { headers: { 'Accept': 'text/html' } })
          .then(response => response.text())
          .then(html => {
            var tempDiv = document.createElement('div');
            tempDiv.innerHTML = html;
            var newTasks = tempDiv.querySelectorAll('#tasks .task');
            var tasksContainer = document.getElementById('tasks');
            newTasks.forEach(function (task) {
              tasksContainer.appendChild(task);
            });
            var newPagination = tempDiv.querySelector('#pagination');
            if (newPagination) {
              pagination.innerHTML = newPagination.innerHTML;
              loading = false;
            } else {
              pagination.remove();
            }
          });
      }
    }
  });
});