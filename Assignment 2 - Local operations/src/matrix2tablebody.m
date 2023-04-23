function matrix2tablebody(matrix, filename, format)
    fid = fopen(filename, 'w');
    
    width = size(matrix, 2);
    height = size(matrix, 1);
    if(~isempty(format))
        format = lower(format);
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
            fprintf(fid, '%s&', matrix{h, w});
        end
        fprintf(fid, '%s\\\\', matrix{h, width});
    end
    for w=1:width-1
        fprintf(fid, '%s&', matrix{height, w});
    end
    fprintf(fid, '%s', matrix{height, width});

    fclose(fid);
end