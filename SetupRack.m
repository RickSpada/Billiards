numRows = 5;
ballsPerRow = 1:numRows;
numBalls = sum(ballsPerRow);

bMass = 1;
bRadius = 1;
bPos = [0 0];

bColors = [
  255 255 0;
  0 0 255;
  255 0 0;
  153 0 153;
  255 128 0;
  0 255 0;
  153 76 0;
  0 0 0
  ] ./ 255;
bColorIdx=0;

rack = cell(numRows, 1);
rack{1} = billiards.Ball(bMass, bRadius, bPos,bColors(bColorIdx+1,:));
bColorIdx = mod(bColorIdx+1,8);

for row = 2:numRows
  prevRowBalls = rack{row-1};
  prevPosX = prevRowBalls(1).Center.X;
  prevPosY = prevRowBalls(1).Center.Y;
  
  % the first ball in this row is positioned left by one radius and down by
  % two radius
  posX = prevPosX - bRadius;
  posY = prevPosY + sqrt(3)*bRadius;
  
  balls = billiards.Ball.empty(0,ballsPerRow(row));
  for b = 1:ballsPerRow(row)
    balls(b) = billiards.Ball(bMass, bRadius, [posX+2*bRadius*(b-1), posY],bColors(bColorIdx+1,:));
    bColorIdx = mod(bColorIdx+1,8);
  end
  
  rack{row} = balls;
end

clf
ax = gca;
ax.YDir = 'reverse';
daspect([1 1 1])
colorIdx = 1;
for row=1:numRows
  balls = rack{row};
  balls(:).draw();
end
