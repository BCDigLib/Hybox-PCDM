# Hybox-PCDM
PCDM Explorations for Hybox, focusing on complex objects from BC

Files currently in this repository:
1. 01C001.xml: a METS structural metadata file in the exact format used to ingest a collection into our current digital repository system.
2. diagram.jgp: a PCDM-oriented mapping of the structure of the archival collection which is represented in the METS file. Note that the METS file only begins at the 3rd level in the diagram.
3. output.json: a JSON-LD file (sort of) that captures the structural metadata from the METS file as PCDM. Contains filesets and ordered items.
4. pcdm.xsl: the transform file used to turn the METS xml file into the PCDM JSON file.
