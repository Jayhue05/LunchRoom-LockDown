
function cords = MotionFcn(FigH, ~)
    figPoint = get(FigH, 'CurrentPoint');
    %disp(['Figure coordinates: ', mat2str(round(figPoint))]);
    cords = (round(figPoint));
end