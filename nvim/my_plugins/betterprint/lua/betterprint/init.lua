local M = {}

local q = require("vim.treesitter.query")


vim.cmd([[
  highlight default PounceGap cterm=bold ctermfg=black ctermbg=darkgreen gui=bold guifg=#555555 guibg=#00aa00
]])

local function get_variable()
    local bufnr = vim.fn.bufnr()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local cursor_row = cursor_pos[1]

    local language_tree = vim.treesitter.get_parser(bufnr)
    local syntax_tree = language_tree:parse()
    local root = syntax_tree[1]:root()

    local query_variable_names = vim.treesitter.parse_query(
        "javascript",
        [[
(variable_declarator
  name: (identifier) @variable_name (#offset! @variable_name)
  )
]]
    )

    local query_arguments = vim.treesitter.parse_query(
        "javascript",
        [[
parameters: ((formal_parameters) @parameters (#offset! @parameters))
  
]]
    )

    local closest_variables = {
        distance = 20,
        row_nr = 0,
        variable_name = {},
    }

    -- TODO check if the variable is a arrow function or similar, in which case you dont want to print it
    for _, match, metadata in
        query_variable_names:iter_matches(
            root,
            bufnr,
            math.max(cursor_row - 10, 0),
            math.max(cursor_row + 10, 0)
        )
    do
        local variable_name = q.get_node_text(match[1], bufnr)
        local row_nr = metadata.content[1][1] + 1
        local distance_to_cursor = row_nr - cursor_row

        -- if two variables are the same distance from the cursor, you want to prioritize the one below
        if distance_to_cursor > 0 then
            distance_to_cursor = distance_to_cursor - 0.5
        end


    --local cursor_col = cursor_position[2]
    --local cursor_pos.col = cursor_position[3]

        local abs_distance_to_cursor = math.abs(distance_to_cursor)
        if abs_distance_to_cursor < closest_variables.distance then
            closest_variables = {
                distance = abs_distance_to_cursor,
                row_nr = row_nr,
                variable_name = { variable_name },
            }
        elseif abs_distance_to_cursor == closest_variables.distance then
            table.insert(closest_variables.variable_name, variable_name)
        end
    end

    for _, match, metadata in
        query_arguments:iter_matches(
            root,
            bufnr,
            cursor_row - 10,
            cursor_row + 10
        )
    do
        local parameter_names = q.get_node_text(match[1], bufnr)
        local row_nr = metadata.content[1][1] + 1
        local distance_to_cursor = row_nr - cursor_row


    print(P(parameter_names))
    local parameter_names_array = {}
    
for name in string.gmatch(parameter_names, '([^,]+)') do
      -- name = name:gsub(/[\(\)]/, "")
      table.insert(parameter_names_array, name)
end

    print(#parameter_names_array)
    print(parameter_names_array[1])

    
        -- if two variables are the same distance from the cursor, you want to prioritize the one above
        if distance_to_cursor > 0 then
            distance_to_cursor = distance_to_cursor + 0.5
        end

        local abs_distance_to_cursor = math.abs(distance_to_cursor)
        if abs_distance_to_cursor < closest_variables.distance then
            closest_variables = {
                distance = abs_distance_to_cursor,
                row_nr = row_nr,
    variable_name = {}
            }

          for i = 1, #parameter_names_array, 1 do
            table.insert(closest_variables.variable_name, parameter_names_array[i])
          end
        elseif abs_distance_to_cursor == closest_variables.distance then
            closest_variables = {
                distance = abs_distance_to_cursor,
                row_nr = row_nr,
    variable_name = {}
            }

          for i = 1, #parameter_names_array, 1 do
            table.insert(closest_variables.variable_name, parameter_names_array[i])
          end
        end
    end

    return closest_variables.variable_name, closest_variables.row_nr
end


local function showSelection(names, row_nr, currentIndex)

    local bufnr = vim.fn.bufnr()
    local name_to_select = names[currentIndex]
    local line_text = vim.fn.getline(row_nr)
    print(P(names))


    local start_index, end_index = string.find(line_text, name_to_select)

    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_buf_clear_namespace(bufnr, 0, 0, -1)

    vim.api.nvim_buf_add_highlight(
        bufnr,
        0,
        "PounceGap",
        row_nr - 1,
        start_index - 1,
        end_index
    )
end

M.BetterPrint = function()
  local variable_names, row_nr = get_variable()

  local current_selection = 1
  showSelection(variable_names, row_nr, current_selection)

  while true do
    local ok, nr = pcall(vim.fn.getchar)



    if not ok then
      break
    end

    if nr == 9 then -- escape
      print(vim.inspect(variable_names))
      current_selection = current_selection +1 
      showSelection(variable_names, row_nr, current_selection)

    else
      break
  end
  end
end

return M
