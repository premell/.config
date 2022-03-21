local M = {}

        local last_x = 0
        local last_y = 0

        M.SayHi = function()

        end

        vim.cmd([[
                autocmd CursorMoved last_x = 10 
        ]])

        print(last_x)

 -- <X1Release>	 X1 button release	    -			*X1Release*
 -- <X2Mouse>	 X2 button pressed	    -			*X2Mouse*

return M
