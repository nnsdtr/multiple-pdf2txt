# DNA Barcoding in Fungi: multiple-pdf2txt

This script parsed `multiple PDF files` inside a specified folder and converted them into `*.txt files` for further text mining approach. `pdf2txt.py` was run employing automatic layout analysis and, as some PDFs presented excessively long conclusion times, we limited the rounds with a timeout of 30 seconds for each PDF conversion round. (For further information on the project, please see the reference cited below)

## Bash version

GNU bash, version 4.3.48(1)-release (x86_64-pc-linux-gnu). Copyright © 2013 Free Software Foundation, Inc.

## Built With

* [PDFminer pdf2txt.py](https://github.com/euske/pdfminer/blob/master/tools/pdf2txt.py) - [euske](https://github.com/euske) - Used to parse PDFs into text files.

## Reference

Badotti, F., Fonseca, P. L. C., Tomé, L. M. R., Nunes, D. T., & Góes-Neto, A. **(2018)**. [ITS and secondary biomarkers in fungi: review on the evolution of their use based on scientific publications. Brazilian Journal of Botany, 1-9.](https://link.springer.com/article/10.1007/s40415-018-0471-y)

## Laboratory
[logo]: https://github.com/nnsdtr/multiple_pdf2txt/blob/master/lbmcf-logo.png

![alt text][logo]
* [**Molecular and Computational Biology of Fungi Laboratory**](https://sites.icb.ufmg.br/lbmcf/) *(LBMCF, ICB - UFMG, Belo Horizonte, Brazil)*

### Author
* **Nunes, D.T.** - [nnsdtr](https://github.com/nnsdtr)

### See also
* [GenBank-lit2tab](https://github.com/nnsdtr/GenBank-lit2tab)
* [barcode-article-miner](https://github.com/nnsdtr/barcode-article-miner)

## Contributing
This repository is supposed to be stable, as it is part of a scientific publication. Instead of commiting here, we kindly ask you to fork the project.
