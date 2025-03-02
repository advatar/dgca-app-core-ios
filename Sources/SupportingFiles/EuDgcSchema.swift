/*-
 * ---license-start
 * eu-digital-green-certificates / dgca-app-core-ios
 * ---
 * Copyright (C) 2021 T-Systems International GmbH and all other contributors
 * ---
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ---license-end
 */
//
//  EuDgcSchema.swift
//
//
//  Created by Yannick Spreen on 4/20/21.
//
//  https://raw.githubusercontent.com/ehn-digital-green-development/ehn-dgc-schema/main/DGC.combined-schema.json
//

import Foundation

// swiftlint:disable line_length
let euDgcSchemaV1 = """
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "https://id.uvci.eu/DGC.combined-schema.json",
  "title": "EU DGC",
  "description": "EU Digital Green Certificate",
  "$comment": "Schema version 1.0.0",
  "required": [
    "ver",
    "nam",
    "dob"
  ],
  "type": "object",
  "properties": {
    "ver": {
      "title": "Schema version",
      "description": "Version of the schema, according to Semantic versioning (ISO, https://semver.org/ version 2.0.0 or newer)",
      "type": "string",
      "pattern": "^\\\\d+.\\\\d+.\\\\d+$",
      "examples": [
        "1.0.0"
      ]
    },
    "nam": {
      "description": "Surname(s), given name(s) - in that order",
      "$ref": "#/$defs/person_name"
    },
    "dob": {
      "title": "Date of birth",
      "description": "Date of Birth of the person addressed in the DGC. ISO 8601 date format restricted to range 1900-2099",
      "type": "string",
      "format": "date",
      "pattern": "(19|20)\\\\d{2}-\\\\d{2}-\\\\d{2}",
      "examples": [
        "1979-04-14"
      ]
    },
    "v": {
      "description": "Vaccination Group",
      "type": "array",
      "items": {
        "$ref": "#/$defs/vaccination_entry"
      },
      "minItems": 1
    },
    "t": {
      "description": "Test Group",
      "type": "array",
      "items": {
        "$ref": "#/$defs/test_entry"
      },
      "minItems": 1
    },
    "r": {
      "description": "Recovery Group",
      "type": "array",
      "items": {
        "$ref": "#/$defs/recovery_entry"
      },
      "minItems": 1
    }
  },
  "$defs": {
    "dose_posint": {
      "description": "Dose Number / Total doses in Series: positive integer, range: [1,9]",
      "type": "integer",
      "minimum": 1,
      "maximum": 9
    },
    "country_vt": {
      "description": "Country of Vaccination / Test, ISO 3166 where possible",
      "type": "string",
      "pattern": "[A-Z]{1,10}"
    },
    "issuer": {
      "description": "Certificate Issuer",
      "type": "string",
      "maxLength": 50
    },
    "person_name": {
      "description": "Person name: Surname(s), given name(s) - in that order",
      "required": [
        "fnt"
      ],
      "type": "object",
      "properties": {
        "fn": {
          "title": "Family name",
          "description": "The family or primary name(s) of the person addressed in the certificate",
          "type": "string",
          "maxLength": 50,
          "examples": [
            "d'Červenková Panklová"
          ]
        },
        "fnt": {
          "title": "Standardised family name",
          "description": "The family name(s) of the person transliterated",
          "type": "string",
          "pattern": "^[A-Z<]*$",
          "maxLength": 50,
          "examples": [
            "DCERVENKOVA<PANKLOVA"
          ]
        },
        "gn": {
          "title": "Given name",
          "description": "The given name(s) of the person addressed in the certificate",
          "type": "string",
          "maxLength": 50,
          "examples": [
            "Jiřina-Maria Alena"
          ]
        },
        "gnt": {
          "title": "Standardised given name",
          "description": "The given name(s) of the person transliterated",
          "type": "string",
          "pattern": "^[A-Z<]*$",
          "maxLength": 50,
          "examples": [
            "JIRINA<MARIA<ALENA"
          ]
        }
      }
    },
    "certificate_id": {
      "description": "Certificate Identifier, format as per UVCI: Annex 2 in  https://ec.europa.eu/health/sites/health/files/ehealth/docs/vaccination-proof_interoperability-guidelines_en.pdf",
      "type": "string",
      "maxLength": 50
    },
    "vaccination_entry": {
      "description": "Vaccination Entry",
      "required": [
        "tg",
        "vp",
        "mp",
        "ma",
        "dn",
        "sd",
        "dt",
        "co",
        "is",
        "ci"
      ],
      "type": "object",
      "properties": {
        "tg": {
          "description": "disease or agent targeted",
          "$ref": "#/$defs/disease-agent-targeted"
        },
        "vp": {
          "description": "vaccine or prophylaxis",
          "$ref": "#/$defs/vaccine-prophylaxis"
        },
        "mp": {
          "description": "vaccine medicinal product",
          "$ref": "#/$defs/vaccine-medicinal-product"
        },
        "ma": {
          "description": "Marketing Authorization Holder - if no MAH present, then manufacturer",
          "$ref": "#/$defs/vaccine-mah-manf"
        },
        "dn": {
          "description": "Dose Number",
          "$ref": "#/$defs/dose_posint"
        },
        "sd": {
          "description": "Total Series of Doses",
          "$ref": "#/$defs/dose_posint"
        },
        "dt": {
          "description": "Date of Vaccination",
          "type": "string",
          "format": "date",
          "$comment": "SemanticSG: constrain to specific date range?"
        },
        "co": {
          "description": "Country of Vaccination",
          "$ref": "#/$defs/country_vt"
        },
        "is": {
          "description": "Certificate Issuer",
          "$ref": "#/$defs/issuer"
        },
        "ci": {
          "description": "Unique Certificate Identifier: UVCI",
          "$ref": "#/$defs/certificate_id"
        }
      }
    },
    "test_entry": {
      "description": "Test Entry",
      "required": [
        "tg",
        "tt",
        "sc",
        "tr",
        "tc",
        "co",
        "is",
        "ci"
      ],
      "type": "object",
      "properties": {
        "tg": {
          "$ref": "#/$defs/disease-agent-targeted"
        },
        "tt": {
          "description": "Type of Test",
          "type": "string"
        },
        "nm": {
          "description": "NAA Test Name",
          "type": "string"
        },
        "ma": {
          "description": "RAT Test name and manufacturer",
          "$ref": "#/$defs/test-manf"
        },
        "sc": {
          "description": "Date/Time of Sample Collection",
          "type": "string",
          "format": "date-time"
        },
        "dr": {
          "description": "Date/Time of Test Result",
          "type": "string",
          "format": "date-time"
        },
        "tr": {
          "description": "Test Result",
          "$ref": "#/$defs/test-result"
        },
        "tc": {
          "description": "Testing Centre",
          "type": "string",
          "maxLength": 50
        },
        "co": {
          "description": "Country of Test",
          "$ref": "#/$defs/country_vt"
        },
        "is": {
          "description": "Certificate Issuer",
          "$ref": "#/$defs/issuer"
        },
        "ci": {
          "description": "Unique Certificate Identifier, UVCI",
          "$ref": "#/$defs/certificate_id"
        }
      }
    },
    "recovery_entry": {
      "description": "Recovery Entry",
      "required": [
        "tg",
        "fr",
        "co",
        "is",
        "df",
        "du",
        "ci"
      ],
      "type": "object",
      "properties": {
        "tg": {
          "$ref": "#/$defs/disease-agent-targeted"
        },
        "fr": {
          "description": "ISO 8601 Date of First Positive Test Result",
          "type": "string",
          "format": "date"
        },
        "co": {
          "description": "Country of Test",
          "$ref": "#/$defs/country_vt"
        },
        "is": {
          "description": "Certificate Issuer",
          "$ref": "#/$defs/issuer"
        },
        "df": {
          "description": "ISO 8601 Date: Certificate Valid From",
          "type": "string",
          "format": "date"
        },
        "du": {
          "description": "Certificate Valid Until",
          "type": "string",
          "format": "date"
        },
        "ci": {
          "description": "Unique Certificate Identifier, UVCI",
          "$ref": "#/$defs/certificate_id"
        }
      }
    },
    "disease-agent-targeted": {
      "description": "EU eHealthNetwork: Value Sets for Digital Green Certificates. version 1.0, 2021-04-16, section 2.1",
      "type": "string",
      "valueset-uri": "valuesets/disease-agent-targeted.json"
    },
    "vaccine-prophylaxis": {
      "description": "EU eHealthNetwork: Value Sets for Digital Green Certificates. version 1.0, 2021-04-16, section 2.2",
      "type": "string",
      "valueset-uri": "valuesets/vaccine-prophylaxis.json"
    },
    "vaccine-medicinal-product": {
      "description": "EU eHealthNetwork: Value Sets for Digital Green Certificates. version 1.0, 2021-04-16, section 2.3",
      "type": "string",
      "valueset-uri": "valuesets/vaccine-medicinal-product.json"
    },
    "vaccine-mah-manf": {
      "description": "EU eHealthNetwork: Value Sets for Digital Green Certificates. version 1.0, 2021-04-16, section 2.4",
      "type": "string",
      "valueset-uri": "valuesets/vaccine-mah-manf.json"
    },
    "test-manf": {
      "description": "EU eHealthNetwork: Value Sets for Digital Green Certificates. version 1.0, 2021-04-16, section 2.8",
      "type": "string",
      "valueset-uri": "valuesets/test-manf.json"
    },
    "test-result": {
      "description": "EU eHealthNetwork: Value Sets for Digital Green Certificates. version 1.0, 2021-04-16, section 2.9",
      "type": "string",
      "valueset-uri": "valuesets/test-results.json"
    }
  }
}
"""
// swiftlint:enable line_length
