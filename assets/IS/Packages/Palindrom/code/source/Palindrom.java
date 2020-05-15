

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class Palindrom

{
	// ---( internal utility methods )---

	final static Palindrom _instance = new Palindrom();

	static Palindrom _newInstance() { return new Palindrom(); }

	static Palindrom _cast(Object o) { return (Palindrom)o; }

	// ---( server methods )---




	public static final void palindromService (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(palindromService)>> ---
		// @sigtype java 3.5
		// [i] field:0:required in
		// [o] field:0:required out
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	in = IDataUtil.getString( pipelineCursor, "in" );
		pipelineCursor.destroy();
		
		String reverse="";
		 for ( int i = in.length()-1; i >= 0; i-- ) 
		 {
		     reverse = reverse + in.charAt(i);  
		 }
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		if(in.equalsIgnoreCase(reverse))
		{
			IDataUtil.put( pipelineCursor_1, "out", "bingo palindrom" );
		}else
		{
			IDataUtil.put( pipelineCursor_1, "out", "oops not palindrom" );
		}
		
		pipelineCursor_1.destroy();
		
			
		// --- <<IS-END>> ---

                
	}
}

