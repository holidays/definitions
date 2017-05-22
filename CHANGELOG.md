# Holiday definitions

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
