function loadFile() {
    const fileInput = document.getElementById('fileInput');
    const fileContentWindow = document.getElementById('fileContentWindow');

    const file = fileInput.files[0];

    if (file) {
        const reader = new FileReader();

        reader.onload = function (e) {
            const fileContent = e.target.result;
            fileContentWindow.textContent = fileContent;
        };

        reader.readAsText(file);
    } else {
        alert('Please select a file');
    }
}

function openTab(tabId) {
    const tabs = document.querySelectorAll('.tab-content');
    tabs.forEach(tab => tab.style.display = 'none');

    const activeTab = document.getElementById(tabId);
    activeTab.style.display = 'block';
}
