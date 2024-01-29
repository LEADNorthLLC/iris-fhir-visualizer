document.addEventListener('DOMContentLoaded', function () {
    const fileInput = document.getElementById('fileInput');
    const fileContentTextarea = document.getElementById('fileContent');
    const apiResponseTextarea = document.getElementById('apiResponse');

    // Set the API endpoint URL
    const apiEndpoint = 'http://localhost:52775/irishealth/csp/visualizer/service/transform';

    function displayFileContent() {
        const file = fileInput.files[0];

        if (file) {
            const reader = new FileReader();

            reader.onload = function (e) {
                const fileContent = e.target.result;
                fileContentTextarea.value = fileContent;
            };

            reader.readAsText(file);
        } else {
            alert('Please select a file');
        }
    }

    function uploadFileToApi1(apiEndpoint) {
        const fileContent = fileContentTextarea.value;

        if (fileContent.trim() !== '') {
            // Simulate an asynchronous request (replace with actual API call)
            fetch(apiEndpoint, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json', // Set the content type to XML
                },
                body: fileContent,
            })
                .then(response => response.text()) // Assuming the response is text (XML)
                .then(data => {
                    // Display the response content
                    displayResponse(data);
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred during the API request.');
                });
        } else {
            alert('Please upload a file and display its content first');
        }
    }

    function uploadFileToApi2() {
        const fileContent = fileContentTextarea.value;

        if (fileContent.trim() !== '') {
            // Simulate an asynchronous request to API 2 (replace with actual API call)
            setTimeout(() => {
                // Simulated response from API 2
                const response = { message: 'File uploaded to API 2 successfully!' };

                // Display the response content
                displayResponse(response);
            }, 1000); // Simulating a delay for demonstration purposes
        } else {
            alert('Please upload a file and display its content first');
        }
    }

    function displayResponse(response) {
        apiResponseTextarea.value = JSON.stringify(response, null, 2);
    }

    window.displayFileContent = displayFileContent;
    window.uploadFileToApi1 = uploadFileToApi1;
    window.uploadFileToApi2 = uploadFileToApi2;
});
