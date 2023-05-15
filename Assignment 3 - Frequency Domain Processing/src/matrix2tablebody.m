function matrix2tablebody(matrix, filename, format, rowLabels, rowSep, colSep)
    fid = fopen(filename, 'w');
    
    width = size(matrix, 2);
    height = size(matrix, 1);
    if(~isempty(format))
        format = lower(format);
    end
    if size(rowLabels,2) ~= 0 & size(matrix,2)~=size(rowLabels,2)
        error("Row label second dimension size has to be eqqual to the second dimension size of the matrix!")
    else
        for i=rowLabels
            fprintf(fid, '%s%c', i, rowSep);
        end
        fprintf(fid, '%c', colSep);
    end

    if isnumeric(matrix)
        matrix = num2cell(matrix);
        for h=1:height
            for w=1:width
                if(~isempty(format))
                    matrix{h, w} = num2str(matrix{h, w}, format);
                else
                    matrix{h, w} = num2str(matrix{h, w});
                end
            end
        end
    end
    
    
    for h=1:height-1
        for w=1:width-1
            fprintf(fid, '%s%c', matrix{h, w}, rowSep);
        end
        fprintf(fid, '%s%c', matrix{h, width}, colSep);
    end
    for w=1:width-1
        fprintf(fid, '%s%c', matrix{height, w}, rowSep);
    end
    fprintf(fid, '%s%c', matrix{height, width}, colSep);

    fclose(fid);
end