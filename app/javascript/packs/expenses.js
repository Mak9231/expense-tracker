document.addEventListener('DOMContentLoaded', () => {
  const form = document.querySelector('form');
  const resultsDiv = document.getElementById('results');

  form.addEventListener('change', (e) => {
    e.preventDefault(); // Empêche le rechargement de la page
    const formData = new FormData(form);
    const queryParams = new URLSearchParams(formData).toString();

    fetch(`/expenses?${queryParams}`, {
      method: 'GET',
      headers: {
        'Accept': 'text/html', // Important pour répondre avec du HTML
      },
    })
      .then(response => response.text())
      .then(data => {
        resultsDiv.innerHTML = data; // Remplace le contenu du div #results
      })
      .catch(error => {
        console.error('Erreur:', error);
      });
  });
});
