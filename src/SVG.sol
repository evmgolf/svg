// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import {Decimal} from 'codec/Decimal.sol';
import {DataURI} from 'uri/Data.sol';

library SVG {
  using Decimal for uint;
  using DataURI for bytes;

  function tag(bytes memory name, bytes memory body) internal pure returns (bytes memory) {
    return bytes.concat("<", name, ">", body, "</", name, ">");
  }

  function tag(bytes memory name, bytes memory body, bytes[] memory keys, bytes[] memory values) internal pure returns (bytes memory _text) {
    _text = bytes.concat("<", name);

    for (uint i=0; i<keys.length; i++) {
      _text = bytes.concat(_text, " ", keys[i], "=\"", values[i], "\"");
    }
    return bytes.concat(_text, ">", body, "</", name, ">");
  }

  function svg(bytes memory body, uint width, uint height) internal pure returns (bytes memory) {
    return bytes.concat("<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 ", width.decimal(), " ", height.decimal(), "\">", body, "</svg>");
  }

  function uriBase64(bytes memory _text) internal pure returns (bytes memory) {
    return _text.dataURIBase64("image/svg+xml");
  }

  function text(bytes memory body, uint x, uint y) internal pure returns (bytes memory) {
    return bytes.concat("<text x=\"", x.decimal(), "\" y=\"", y.decimal(), "\">", body, "</text>");
  }
}
