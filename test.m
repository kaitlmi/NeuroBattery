%Digit span task (working memory, utilizes sorting and audio)

% variables
score_span = 0 ;
count = 1 ;
rounds = 2;
error_span = 0;

%loop
while count <= rounds
	ii =  count ;
	span_output = randi( 9, 1, ii)
    x = span_output
%span_input = GetEchoString(window, 'Type the digits here:', 700, 675, black, white);
	if  span_output == x
		score_span = score_span + 1;
		count = count + 1;
	else
		error_span = error_span + 1;
        span_output = randi( 9, 1, ii); 
end
end
disp(score_span)
disp(error_span)

