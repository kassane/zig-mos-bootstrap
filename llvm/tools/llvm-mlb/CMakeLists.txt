set(LLVM_LINK_COMPONENTS
  Object
  Support
  )

add_llvm_tool(llvm-mlb llvm-mlb.cpp)
