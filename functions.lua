function ItemCategory.IsWood(aBlockID)
	return (
		(aBlockID == E_BLOCK_LOG) or
		(aBlockID == E_BLOCK_NEW_LOG)
	)
end

function GetSaplingMeta(aBlockType, aBlockMeta)
	if (aBlockType == E_BLOCK_LOG) then
		return a_BlockMeta
	end

	return aBlockMeta + 4
end