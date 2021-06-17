# PartiQL Language Specification

This is the LaTeX source for the [PartiQL] specification.

## Building

As a prerequisite, you need the following:

* A LaTeX distribution such as [TeX Live][texlive].
* GNU Make.

To build a PDF, `cd` to `spec` and then:

```
$ make
```

The PDF will be placed in `spec/build/main.pdf`.

To clean up the various build files including the PDF:

```
$ make clean
```

## License

This library is licensed under the [PartiQL Specification License][license]. 

[partiql]: https://partiql.org/
[texlive]: https://www.tug.org/texlive/
[license]: LICENSE

