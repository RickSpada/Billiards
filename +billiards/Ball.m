classdef Ball < handle
  %Ball Object definition of a Billiard bball
  
  properties (SetAccess=immutable)
    Mass
    Radius
  end
  
  properties
    PrivateCenter      % billiards.Coordinate object
    PrivateColor       % rgb vector
  end
  
  properties (Dependent=true)
    Center
    Color
  end
  
  properties (Access=private, Transient=true)
    hPoly       % handle to polygon
  end
  
  %% Constructor / Destructor
  methods
    
    function obj = Ball(m, r, pos, rgb)
      obj.Mass = m;
      obj.Radius = r;
      obj.Center = billiards.Coordinate(pos);
      
      if nargin < 4,
        rgb = [1 1 1];
      end
      
      obj.Color = rgb;
      obj.hPoly = [];
    end
    
    function delete(obj)
      delete(obj.hPoly)
    end
    
  end
  
  %% Drawing methods
  methods
    
    function draw(objArray)
      for i=1:length(objArray)
        obj = objArray(i);
        [x,y] = cylinder(obj.Radius);
        x = x(1,:) + obj.Center.X;
        y = y(1,:) + obj.Center.Y;
        
        if isempty(obj.hPoly)
          obj.hPoly = patch('XData',x,'YData',y,'FaceColor',obj.Color);
        else
          set(obj.hPoly,'XData',x,'YData',y);
        end
      end
    end
    
  end
  
  %% get/set methods
  methods
    function val = get.Mass(obj)
      val = obj.Mass;
    end
    
    function val = get.Radius(obj)
      val = obj.Radius;
    end
  end
  
  %% Dependent property get/set methods
  methods
    function val = get.Center(obj)
      val = obj.PrivateCenter;
    end
    
    function set.Center(obj,pos)
      obj.PrivateCenter = billiards.Coordinate(pos);
    end
    
    function rgb = get.Color(obj)
      rgb = obj.PrivateColor;
    end
    
    function set.Color(obj,rgb)
      obj.PrivateColor = rgb;
      if ~isempty(obj.hPoly) && isgraphics(obj.hPoly)
        obj.hPoly.FaceColor = rgb;
      end
    end
    
  end
  
end