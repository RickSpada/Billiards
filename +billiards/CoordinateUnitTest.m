classdef CoordinateUnitTest < matlab.unittest.TestCase
  % Unit tests for Coordinate class
  
  methods (Test)
    
    function testNoArgCtor(testCase)
      actCoord = billiards.Coordinate;
      expCoord = [0 0];
      testCase.verifyEqual(double(actCoord),expCoord);
    end
    
    function testTwoArgCtor(testCase)
      actCoord = billiards.Coordinate(1, 2);
      expCoord = [1 2];
      testCase.verifyEqual(double(actCoord),expCoord);
    end
    
    function testOneArgCtorCopy(testCase)
      expCoord = billiards.Coordinate(1, 2);
      actCoord = billiards.Coordinate(expCoord);
      testCase.verifyEqual(actCoord,expCoord);
    end
    
    function testOneArgCtorVector(testCase)
      actCoord = billiards.Coordinate([1 2]);
      expCoord = billiards.Coordinate(1, 2);
      testCase.verifyEqual(actCoord,expCoord);
    end
    
  end
  
end

