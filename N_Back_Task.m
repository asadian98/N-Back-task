clc, clear

% Set the task parameters
letters = ['A', 'B', 'C', 'D', 'E', 'G', 'I', 'K', 'L', 'M', 'O', 'P', 'T', 'X', 'Z'];
numTrials = 50;

% print instruction
Idx = randi(size(letters, 2), 1, numTrials); 
disp("Programming course, Final Project...")
disp("Demonstration of a 2-back task...")
disp(" ")
disp("In this task, you will see letters. Each letter is shown for 500 ms.")
disp("You need to decide if you saw the same letter 2 letters ago or not")
disp(" ")

% Get username
Username = input("Please enter your name : ", 's');

% Is the user ready ?
while(input("Are you ready ? press 'y' to start : ", 's') ~= 'y')
    
    clc
    disp("Programming course, Final Project...")
    disp("Demonstration of a 2-back task...")
    disp(" ")
    disp("In this task, you will see letters. Each letter is shown for 500 ms.")
    disp("You need to decide if you saw the same letter 2 letters ago or not")
    disp(" ")
    disp("press 'y' to start")
    disp(" ")

end

clc
disp("1...")
pause(0.5)
clc
disp("2...")
pause(0.5)
clc
disp("3...")
pause(0.5)
clc
disp("Start...")
pause(0.5)
clc

% Start the task
seq = [];
numMatch = 0;
numFalse = 0;
corrMatch = 0;

for i = 1:numTrials
    
    disp(letters(Idx(i)))
    pause(0.5)
    clc
    
    % If the input is not correct
    try
        seq(i) = input("'y' (yes) or 'n' (no) : ", 's');
    catch
        error("Error : You have to press 'y' or 'n', Please try again...");
    end
    
    if(~ismember(seq(i), ['y', 'n']))
        error("Error : You have to press 'y' or 'n', Please try again...");
    end
    
    % check the input
    
    if(i <= 2 && seq(i) == 'y') % for the first two letters
        disp('wrong')
        numFalse = numFalse + 1;
    elseif(i <= 2 && seq(i) == 'n')
        disp('correct')
    elseif(seq(i) == 'y' && letters(Idx(i-2)) == letters(Idx(i)))
        disp('correct')
        numMatch = numMatch + 1;
    elseif(seq(i) == 'n' && letters(Idx(i-2)) ~= letters(Idx(i)))
        disp('correct')
    elseif(seq(i) == 'n' && letters(Idx(i-2)) == letters(Idx(i)) || seq(i) == 'y' && letters(Idx(i-2)) ~= letters(Idx(i)))
        disp('wrong')
        numFalse = numFalse + 1;
    end
    
    % Calculate the number of matches in the sequence
    if(i >= 3)
        if(letters(Idx(i-2)) == letters(Idx(i)))
            corrMatch = corrMatch + 1;
        end
    end
    
    % 500 ms
    pause(0.5)
    clc
end

% print the results
disp(['There were ', num2str(numTrials), ' trials in total in this task.'])
disp(['Total trials that had a match: ', num2str(corrMatch)])
NotcorrMatch = numTrials - corrMatch;
disp(['Total trials that had not a match: ', num2str(NotcorrMatch)])

disp(['Number of correctly matched items: ', num2str(numMatch)])
disp(['Number of false alarms: ', num2str(numFalse)])

if(corrMatch ~= 0)
    PercCorrMatch = round(numMatch / corrMatch * 100);
    disp(['Percentage correct matches: ', num2str(PercCorrMatch), '%'])
else
    PercCorrMatch = 0;
    disp(['Percentage correct matches: ', num2str(PercCorrMatch), '%'])
end

if(numTrials - corrMatch ~= 0)
    PercFalseAlarms = round(numFalse / NotcorrMatch * 100);
    disp(['Percentage false alarms: ', num2str(PercFalseAlarms), '%'])
else
    PercFalseAlarms = 0;
    disp(['Percentage false alarms: ', num2str(PercFalseAlarms), '%'])
end

% Save the output
save([Username, '.mat'], 'Username', 'letters', 'numTrials', 'Idx', 'seq',...
    'numMatch', 'numFalse', 'corrMatch', 'NotcorrMatch', 'PercCorrMatch', 'PercFalseAlarms')