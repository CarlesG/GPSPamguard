function [merged_struct] = mergeStructs(struct_a,struct_b,pretext)

% Function to merge two structures together
% This assumes that the structure passed is not an array (e.g. length=1).
% The pretext will be added in front of each fieldname from struct_b, to
% avoid duplication


%%if one of the structures is empty do not merge
if isempty(struct_a)
    merged_struct=struct_b;
    return
end
if isempty(struct_b)
    merged_struct=struct_a;
    return
end

%%insert struct a
merged_struct=struct_a;

%%insert struct b
f = fieldnames(struct_b);
for i = 1:length(f)
    merged_struct(1).([pretext f{i}]) = struct_b.(f{i});
end
end
