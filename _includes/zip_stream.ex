defmodule ZipStream do


	#Public api

	def stream!({_, bin}) when is_binary(bin) do
		stream(:zip.zip_open(bin, [:memory]))
	end

	def stream!(fname) when is_binary(fname) do
		stream(:zip.zip_open(String.to_char_list(fname), [:memory]))
	end


	#private
	defp stream({:ok, handle}) do
		Stream.resource(
		fn->open_stream(handle) end, 

		fn(k)-> next_fun(k) end,

		fn(k) -> close(k) end
		)
	end

	defp open_stream(handle) do
		{:ok,  [_|listing]} = :zip.zip_list_dir(handle)
		newstate = Enum.map(listing, fn(r) ->{:zip_file, fname, _, _, _, _} = r;fname end) 
		{handle, newstate}
	end

	defp close({pid, _list}) do
		:ok = :zip.zip_close(pid) 
	end

	defp close(pid) do
		:ok = :zip.zip_close(pid) 
	end

	defp next_fun({handle, []}) do
		{:halt, handle}
	end

	defp next_fun({handle, [n|rest]})do 
		case :zip.zip_get(n, handle) do
			{:ok, result} -> {[result], {handle, rest}}
			_ -> next_fun({handle, []})
		end
	end
end

