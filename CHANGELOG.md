# Holiday definitions

## 2.2.0

* Audit provincial holidays in Canada (thanks to https://github.com/slucaskim)
* Add civic holiday for `ca_pe`  (thanks to https://github.com/slucaskim)
* Correct reformation day for `de` (thanks to https://github.com/spaceneedle2019)

## 2.1.1

* Comment out test for `추석` until a discussion can be had in [issue 69](https://github.com/holidays/definitions/issues/69) (nice)

## 2.1.0

Update the following regions:

* `ca_ab` - change 'Heritage Day' to informal
* `kr` - Update '추석 연휴' and `설날 연휴` for accuracy
* `cl` - Add 'San Pedro y San Pablo', update 'Encuentro de Dos Mundos', and add 'Día de las Iglesias Evangélicas y Protestantes'

## 2.0.0

* Update `tr`, `fedex` for accuracy
* Completely change the test format to no longer use ruby source code! Hooray! This should cause no behavior differences,
  any differences or changes in behavior should be considered a regression.

## 1.7.1

A small bugfix that resolves the naming issues of two regions in the 'index.yaml' file. No other outward changes.

## 1.7.0

Here are the changes:

* Add Estonian definitions
* Enhance France definitions
* Correct and enhance German definitions
* Enhance Portuguese definitions
* Add Malta definitions
* Add Serbian definitions
* Add Georgian definitions
* Use Orthodox easter calculations in appropriate regions
* Add Russian definitions
* Add Turkey definitions
* Enhance US definitions (lots of individual US states!)
* Update South Australian definitions

## 1.6.1

* Update `ca` test for correctness. See below for more information.

Unfortunately due to our current setup it is possible for definitions/tests in this repository to appear 'valid' but only
fail when we run them in the actual ruby holidays repo. This is a known issue (#42) and needs to be addressed.

In the meantime, this is a bugfix release to ensure we can release v5.6.0 of the ruby repo.

## 1.6.0

Updates to the following Canadian regions: `ca_ab, ca_bc, ca_mb, ca_nt, ca_nu, ca_on, ca_sk, ca_yt, ca_pe`

## 1.5.1

* Fix error in `fedex` custom method `day_after_thanksgiving`

## 1.5.0

* Update NYSE to fix observed NYD
* Use native language for KR
* Use native language for VI
* Update AU definitions for accuracy
* Update KR definitions to include lunar holiday calculations
* Add VI definitions

## 1.4.0

* :au - corrects holidays for certain regions
* :vi - reports holiday names in Vietnamese instead of English, adds 1 additional holiday (Giỗ tổ Hùng Vương)

## 1.3.0

* Add Travis badge to README
* Add Tunisian holidays
* Correct various Australian holidays
* Updates various German regions to be more accurate
* Changed 'nf' to 'nl' for Newfoundland & Labrador
* Changed 'yk' to 'yt'kkk

## 1.2.1

* Fix syntax and test errors in au and ca def tests

## 1.2.0

* updates jp defs to fix 'Foundation Day' name
* Fix ca defs for observed holidays
* Update au defs to have Christmas and Boxing Day for all of Australia instead of just individual territories
* Update ie defs to consolidate "St Stephen's Day" to use common method instead of custom method

## 1.1.0

* Add HK definitions
* Add KR definitions
* Fix small bug in JP definitions

## 2016 1.0.0

Initial creation of this repository

This contains all of the definitions currently in the holidays repository but split out into its own repository. It will
be added as a submodule of the ruby repository, which will be responsible for generating its final classes.

The idea is that we will have repositories for multiple languages and each language is responsible for using the definitions
as it sees fit.
