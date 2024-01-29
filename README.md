# Iris FHIR and CCDA Visualizer




## Install

Clone this repository

```
git clone https://github.com/LEADNorthLLC/iris-fhir-visualizer.git
```

Docker

```
docker-compose up --build -d
```

## Usage



## Api details

### CCDA to FHIR
```
POST http://localhost:45451/csp/healthshare/visualizer/fileupload.html
```

#### Example

<details>
  <summary>Input</summary>
  
  ```text
CCDA  
```
  
</details>

<details>
  <summary>Output</summary>
  
  ```xml
  SDA here
  ```
  
</details>




### CDA to FHIR
```
POST http://localhost:45451/csp/visualizer/service
```

#### Example

<details>
  <summary>Input</summary>
  
  ```xml

  ```
  
</details>

<details>
  <summary>Output</summary>
  
  ```text

  ```
  
</details>


## How it's working

This project works with the pivot diagram: SDA.

The SDA (Summary Document Architecture) is the InterSystems Clinical Data Format. 

The SDA <-> FHIR correspondences can be consulted [here](https://docs.intersystems.com/irisforhealthlatest/csp/docbook/Doc.View.cls?KEY=HXFHIR_transforms), and those of the CDA -> SDA [here](https://docs.intersystems.com/irisforhealthlatest/csp/docbook/DocBook.UI.Page.cls?KEY=HXCDA).



