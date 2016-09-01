classdef Coordinate
  %Coordinate Definintion of an X/Y coordinate for a billiard ball.
  
  %% Properties
  properties (SetAccess = immutable)
    X
    Y
  end
  
  %% Constructor and related helper methods
  methods
    function obj = Coordinate(varargin)
      switch numel(varargin)
        case 0
          [xPos,yPos] = NoArgsCtor;
          
        case 1
          arg = varargin{1};
          if isa(arg, 'billiards.Coordinate')
            [xPos,yPos] = OneArgCtorCopy(varargin{1});
          elseif isnumeric(arg)
            if numel(arg) ~= 2
              me = MException('Billards:VectorTooLong',...
                'Input vector must be of length 2');
              throw(me)
            end
            
            xPos = arg(1);
            yPos = arg(2);
            
          else
            me = MException('Billards:NotACoordinate',...
              'Input must be another ''Coordinate'' object');
            throw(me)
          end
          
        case 2
          xPos = varargin{1};
          yPos = varargin{2};
          if ~isNumericScalar(xPos) || ~isNumericScalar(yPos)
            me = MException('Billards:NotNumberic',...
              'Inputs must be scalar numerics');
            throw(me)
          end
          
        otherwise
          me = MException('Billards:NotNumberic',...
            'Too many inputs (%d)', nargin);
          throw(me)
      end
      
      obj.X = xPos;
      obj.Y = yPos;
      
      function [xPos,yPos] = NoArgsCtor
        xPos = 0;
        yPos = 0;
      end
      
      function [xPos,yPos] = OneArgCtorCopy(coord)
        xPos = coord.X;
        yPos = coord.Y;
      end
      
    end
  end
  
  %% Get / Set methods
  methods
    
    function xPos = get.X(obj)
      xPos = obj.X;
    end
    
    function yPos = get.Y(obj)
      yPos = obj.Y;
    end
    
  end
  
  %% Public methods
  methods
    
    function vec = double(obj)
      vec = [obj.X obj.Y];
    end
    
    function tf = isequal(obj1, obj2)
      tf = isequal(double(obj1), double(obj2));
    end
    
  end
  
end

%% Helper functions
function out = isNumericScalar(x)
  out = isnumeric(x) && isscalar(x);
end


