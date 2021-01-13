function smsopen(varargin)

% This function opens the necessary files.. according to wchiever programming i am doing..




switch varargin{1}
    case {'fem','afea','sfeam','f'}
        open sms
        open SFEAM
        open AGG
    case {'sa','mc'}
    case {'md'}
end


end