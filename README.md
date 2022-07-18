# Ingenieria del Software II - Template

![GHA Status](https://github.com/uca-is2/2022-los-small-talkers/actions/workflows/GHA.yml/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/uca-is2/2022-los-small-talkers/badge.svg?branch=master)](https://coveralls.io/github/uca-is2/2022-los-small-talkers?branch=master)

## Metacello

```smalltalk
Metacello new
   baseline: 'IngSoft2';
   githubUser: 'uca-is2' project: '2022-los-small-talkers' commitish: 'master' path: 'repository';
   load: 'development'.
```
