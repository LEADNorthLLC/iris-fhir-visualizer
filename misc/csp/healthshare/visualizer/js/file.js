document.addEventListener('DOMContentLoaded', function () {
    const fileInput = document.getElementById('fileInput');
    const fileContentTextarea = document.getElementById('fileContent');
    const apiResponseTextarea = document.getElementById('apiResponse');
    const apiResponseSDATextarea = document.getElementById('sdaResponse');
    const apiResponseFHIRTextarea = document.getElementById('fhirResponse');
    const activeTab = document.getElementById('sdaTab');

    // Display the default tab content
    //openTab('#sdaTab');

	const apiEndpoint = 'http://localhost:52775/irishealth/csp/visualizer/service/transform';
    
     // Function to open a specific tab
     function openTab(tabId) {
        const tabs = document.querySelectorAll('.tab-content');
        tabs.forEach(tab => tab.style.display = 'none');
    
        const activeTab = document.getElementById(tabId);
        activeTab.style.display = 'block';
    }

   	function displayFileContent() {
        const file = fileInput.files[0];

        if (file) {
            const reader = new FileReader();

            reader.onload = function (e) {
                const fileContent = e.target.result;
                fileContentTextarea.value = fileContent;
				$("#prettyPrint").simpleXML({
					xmlString: fileContent
				});
				$("#prettyPrint").simpleXML({
					xmlString: xml,
					collapsedText:"..."
				});

                // Try parsing the file content as XML
                try {
                    const parser = new DOMParser();
                    const xmlDoc = parser.parseFromString(fileContent, 'application/xml');
                    const xmlString = new XMLSerializer().serializeToString(xmlDoc);

                    // Format and display XML as a collapsible tree
                    const formattedXml = prettyPrintXml(xmlString);
                    fileContentTextarea.value = formattedXml;
                } catch (error) {
                    // If parsing as XML fails, keep the raw file content
                    console.error('Error parsing XML:', error);
                }
            };

            reader.readAsText(file);
        } else {
            alert('Please select a file');
        }
    }
	
   
    
    function uploadFileToApi1_backup() {
        const fileContent = fileContentTextarea.value;
		 const format = document.querySelector('input[name="format"]:checked').value;

        if (fileContent.trim() !== '') {
            // Simulate an asynchronous request (replace with actual API call)
            fetch(apiEndpoint, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json', // Set the content type to JSON
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

    function uploadFileToApi1() {
        const fileContent = fileContentTextarea.value;

        if (fileContent.trim() !== '') {
            // Simulate an asynchronous request (replace with actual API call)
            fetch(apiEndpoint, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: fileContent,
            })
            .then(response => response.text())
            .then(data => {
                // Display the response content in the appropriate tab
                displayApiResponse(data);
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

    function displayApiResponse(response) {
       

        try {
            const parser = new DOMParser();
            const xmlDoc = parser.parseFromString(response, 'application/xml');
            const xmlString = new XMLSerializer().serializeToString(xmlDoc);
            const formattedXml = prettyPrintXml(xmlString);
            apiResponseSDATextarea.value = formattedXml;
        } catch (error) {
            apiResponseSDATextarea.value = response;
        }
    }

    function prettyPrintXml(xmlString) {
        const pd = new prettydata();
        return pd.pd.xml(xmlString);
    }


	// Function to format XML content
	function formatXml(xmlString) {
		const parser = new DOMParser();
		const xmlDoc = parser.parseFromString(xmlString, 'application/xml');
		const xmlStringIndented = new XMLSerializer().serializeToString(xmlDoc);
		return xmlStringIndented;
	}
	

    window.displayFileContent = displayFileContent;
    window.uploadFileToApi1 = uploadFileToApi1;
    window.uploadFileToApi2 = uploadFileToApi2;
    window.openTab = openTab;
});
