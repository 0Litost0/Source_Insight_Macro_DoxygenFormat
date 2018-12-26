

// Finds matching scoping delimiters and jumps to them.
// If the cursor is not positioned on a delimiter but is inside 
// a matching part the macro will jump to the start of the closest
// scope. Currently matches [],(),<>,{}
macro siMatchDelim2()
{
	hwnd = GetCurrentWnd()
	buff = GetCurrentBuf()
    if (hwnd != 0 && buff != 0 )
	{
		sel = GetWndSel(hwnd)
        cur_line = GetBufLine( buff, sel.lnFirst )
        cur_char = cur_line[sel.ichFirst]
        match_sel = 0

        
		if( siIsLeftDelim( cur_line, sel.ichFirst ) )
            match_sel = siMatchLeftDelim( cur_char, buff, sel, hwnd )
		else if( siIsRightDelim( cur_line, sel.ichFirst ) )
  		    match_sel = siMatchRightDelim( cur_char, buff, sel, hwnd )
		else
            match_sel = siFindFirstLeftDelim(buff, sel, hwnd )

		if( match_sel )
		{
    	    match_sel.lnLast = match_sel.lnFirst
    	    match_sel.ichLim = match_sel.ichFirst
		    SetWndSel( hwnd, match_sel )

		    // If the new selection is not visible scroll to it
			_tsUpdateInsertion(hwnd, match_sel)
		}
	}
}


macro _tsUpdateInsertion(hwnd, sel)
{
	lnTop = GetWndVertScroll(hwnd);
	cLines = GetWndLineCount(hwnd);

	if (lnTop > sel.lnFirst)
	{
		ScrollWndToLine(hwnd, sel.lnFirst); 
	}

	if (lnTop + cLines <= sel.lnFirst)
	{
		lnTop = sel.lnLast - cLines + 1;
		ScrollWndToLine(hwnd, lnTop); 
	}
}



macro siMatchLeftDelim( left_delim, buff, sel, hwnd )
{
    // Special case paren because the built in stuff is much faster
    if( cur_char == "(" )
    {
        Paren_Right
		return GetWndSel(hwnd)
    }
    
    right_delim = siGetRightDelim( left_delim )
    nest = 1
    
    cur_line = sel.lnFirst
    cur_pos = sel.ichFirst + 1
    
    buff_lines = GetBufLineCount(buff) 
    while( cur_line < buff_lines )
    {
        line = GetBufLine( buff, cur_line )
        line_len = GetBufLineLength( buff, cur_line )
        while( cur_pos < line_len )
        {
            if( line[cur_pos] == left_delim )
                nest = nest + 1
            else if( line[cur_pos] == right_delim )
            {
                nest = nest - 1
                if( nest == 0 )
                {
                    sel.lnFirst = cur_line
                    sel.ichFirst = cur_pos
                    return sel
                }
            }

            cur_pos = cur_pos + 1
        }

        cur_line = cur_line + 1
        cur_pos = 0;
    }

    return 0
}

macro siMatchRightDelim( right_delim, buff, sel, hwnd )
{
    // Special case paren because the built in stuff is much faster
    if( cur_char == ")" )
    {
        Paren_Left
		return GetWndSel(hwnd)
    }
            
    left_delim = siGetLeftDelim( right_delim )
    nest = 1
    
    cur_line = sel.lnFirst
    cur_pos = sel.ichFirst - 1
    
    while( cur_line >= 0 )
    {
        line = GetBufLine( buff, cur_line )
        while( cur_pos >= 0 )
        {
            if( line[cur_pos] == right_delim )
                nest = nest + 1
            else if( line[cur_pos] == left_delim )
            {
                nest = nest - 1
                if( nest == 0 )
                {
                    sel.lnFirst = cur_line
                    sel.ichFirst = cur_pos
                    return sel
                }
            }

            cur_pos = cur_pos - 1
        }

        cur_line = cur_line - 1
        if( cur_line >= 0 )
            cur_pos = GetBufLineLength( buff, cur_line )
    }

    return 0
}

macro siFindFirstLeftDelim( buff, sel, hwnd )
{
    while( sel.lnFirst >= 0 )
    {
        line = GetBufLine( buff, sel.lnFirst )
        while( sel.ichFirst >= 0 )
        {
            if( siIsRightDelim( line, sel.ichFirst ) )
            {
                jump_sel = siMatchRightDelim( line[sel.ichFirst], buff, sel, hwnd )
                if( jump_sel )
                {
                    sel = jump_sel
                    line = GetBufLine( buff, sel.lnFirst )
                }
            }
            else if( siIsLeftDelim( line, sel.ichFirst) )
            {
                return sel
            }

            sel.ichFirst = sel.ichFirst - 1
        }

        sel.lnFirst = sel.lnFirst - 1
        if( sel.lnFirst >= 0 )
            sel.ichFirst = GetBufLineLength( buff, sel.lnFirst )
    }

    return 0
}


macro siIsLeftDelim( line, pos )
{
    if( line[pos] == "(" ||
        line[pos] == "{" ||
        line[pos] == "[" ||
        line[pos] == "<"    )
        return 1
    else
        return 0
}

macro siIsRightDelim( line, pos )
{
    back_pos = 0
    if( pos > 0 )
        back_pos = pos - 1

    if( line[pos] == ")" ||
        line[pos] == "}" ||
        line[pos] == "]" ||
        // The account for C-style pointer->member
        (line[pos] == ">" && (pos == 0 || line[back_pos] != "-")   )
        return 1
    else
        return 0
}

macro siGetRightDelim( left_delim )
{
    if( left_delim == "(" )
        return ")"
    else if( left_delim == "{" )
        return  "}"
    else if( left_delim == "[" )
        return  "]"
    else if( left_delim == "<" )
        return  ">"
    else
        return "-"
}

macro siGetLeftDelim( right_delim )
{
    if( right_delim == ")" )
        return "("
    else if( right_delim == "}" )
        return  "{"
    else if( right_delim == "]" )
        return  "["
    else if( right_delim == ">" )
        return  "<"
    else
        return "-"
}


// SI does not include \n in buffer
macro siNormSel(hbuf, sel)
{
	if (sel.ichLim >= GetBufLineLength(hbuf, sel.lnLast))
	{
		sel.lnLast = sel.lnLast + 1
		sel.ichLim = 0
    }

	return sel
}

