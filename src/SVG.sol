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
    bytes[] memory keys = new bytes[](2);
    keys[0] = "xmlns";
    keys[1] = "viewBox";
    bytes[] memory values = new bytes[](2);
    values[0] = "http://www.w3.org/2000/svg";
    values[1] = bytes.concat("0 0 ", width.decimal(), " ", height.decimal());
    // return bytes.concat("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>", tag("svg", body, keys, values));
    return tag("svg", body, keys, values);
  }

  function uriBase64(bytes memory _text) internal pure returns (bytes memory) {
    return _text.dataURIBase64("image/svg+xml");
  }

  function text(bytes memory body, uint x, uint y) internal pure returns (bytes memory) {
    bytes[] memory keys = new bytes[](2);
    bytes[] memory values = new bytes[](2);
    keys[0] = "x";
    values[0] = x.decimal();
    keys[1] = "y";
    values[1] = y.decimal();
    return tag("text", body, keys, values);
  }
}
