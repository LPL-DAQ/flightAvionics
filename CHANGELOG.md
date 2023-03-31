# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Useful links: 
[Start Up Procedure:](https://docs.google.com/document/d/1HFaLLYg40X4o-dengaRjggNb5vt6SatAqXU8YXTvmBo/edit?usp=sharing)

## [1.1.0] - 2023-3-31
Quick update this time around just in time for the first cold flow on the fuel side (what a coincidence). Lodecell implementation and console access will be in the upcoming patch. Special thanks to Galkathe for their contribute to this update.

### What's New
- Stepper motor base implementation
- Value error handling on PT ini file
- Added some descriptive comments to the code

### Bug Fixes
- Removed some unnecessary print statements on startup
- Fixed a divide by 0 error if pt_poll or sendrate in config.ini were set to 0 (will set the sleep to 0 instead)
- Autogenerate data directory if it is not in the source code

## [1.0.0] - 2023-03-06
First working version of the DAQ!!! 🥳🥳🥳
Petition to make today a national LPL holiday

### What's New
- Basic DAQ server and client functionality
- PT and TC sensors
- Solenoid actuation (one per command)
- Data logging
- Server kill prototype