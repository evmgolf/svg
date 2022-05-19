// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;
import "forge-std/Test.sol";
import {SVG} from "../SVG.sol";

contract SVGTest is Test {
  function testOutputsSomethingTag(bytes calldata name, bytes calldata body) public {
    assertGt(SVG.tag(name, body).length, 0);
  }

  function testOutputsSomethingTag(bytes calldata name, bytes calldata body, bytes[] calldata keys, bytes[] calldata values) public {
    if (keys.length > values.length) {
      vm.expectRevert(stdError.indexOOBError);
      SVG.tag(name, body, keys, values);
    } else {
      assertGt(SVG.tag(name, body, keys, values).length, 0);
    }
  }

  function testOutputsSomethingSVG(bytes calldata body, uint width, uint height) public {
    assertGt(SVG.svg(body, width, height).length, 0);
  }

  function testOutputsSomethingURIBase64(bytes calldata text) public {
    assertGt(SVG.uriBase64(text).length, 0);
  }

  function testOutputsSomethingText(bytes calldata body, uint x, uint y) public {
    assertGt(SVG.text(body, x, y).length, 0);
  }
}
