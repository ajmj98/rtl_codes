///(immediate and direct addressing mode and 3 address instruction)
//harward architecture//
//////////IR FIELDS///////
`define op_code        ir[31:27]
`define dst_reg        ir[26:22]
`define src_reg1       ir[21:17]
`define mode           ir[16]
`define src_reg2       ir[15:11]
`define unsd           ir[15:0]

//////////OPERATION TYPE DECLARATION///////////


//aritmetic and load operaation
`define movsgpr        5'b00000
`define mov            5'b00001 
`define add            5'b00010
`define sub            5'b00011
`define mul            5'b00100  

//logical operation//////////
`define lor            5'b00101
`define land           5'b00110
`define lxor           5'b00111
`define lxnor          5'b01000
`define lnor           5'b01001
`define lnand          5'b01010
`define lnot           5'b01011

////////////memory operations////////
`define ld_din_dtm    5'b01100
`define ld_reg_dtm    5'b01101
`define send_dtm_dout 5'b01110
`define send_dtm_reg  5'b01111

///////////jump instructions////////
`define jmp           5'b10000
`define jcry          5'b10001
`define jncry         5'b10010
`define jsgn          5'b10011
`define jnsgn         5'b10100
`define jz            5'b10101
`define jnz           5'b10110
`define jovf          5'b10111
`define jnovf         5'b11000


//////////////////halt operation//////
`define hlt           5'b11001


module core(
    input clk,
    input sys_rst,
    input [15:0] din,
    output reg [15:0] dout
);


	reg [31:0] ir;                                   //Instruction reg//////31-27(op)-----26-22(dr)-----21-17(sr1)-----16(m)------15-11(sr2)------10-0(unused)

	reg [15:0] gpr [31:0] ; 			 // 32 16-bit general purpose register 

	reg [15:0] sgpr;                                 //// multiplication MSB bits(result of 2 16 bit is 32 bits which is stored is sgpr and destination register specified in IR

	reg [31:0] mul_result;                           //temp reg for multiplication
	
	reg sign=0,zero=0,ov=0,cry=0;                    ///STATUS FLAGS

	reg jmp_flg;                                     // jump indicator
	 
	reg stop;                                        //stop operations

	reg tmp_cry=0;                                   // Temp flag for carry
	
        reg [3:0] PC;                                    ///PROGRAM COUNTER
	reg [31:0] pgm_mem [0:15];
        reg [15:0] data_mem[0:15];

       integer count=0,i;



//////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////INITIALIZE PROGRAM MEMORY/////////////////////////////////////

    initial 
    begin
        $readmemb("pgm_mem_init.mem",pgm_mem);
	for( i=0;i<16;i=i+1)
	   begin
	    gpr[i]=0;
	  end
   //$writememb("data_mem_i.mem"data_mem);

    end



 

//////////////////////////////////////////////////////////////////////////////////////////////////////////////    
/////////////////////////////////////////////LOGIC FOR INSTRUCTION  EXECUTION/////////////////////////////////

    task instrt_exec();
    begin
	tmp_cry =0;
	case(`op_code)

////////////////////////////////////////////////////////////////////////////////////////////////////
//MOVE TO SPECIAL REGISTER		
	    `movsgpr: 
	    begin
	        gpr[`dst_reg]<=sgpr;
	    end

			
///////////////////////////////////////////////////////////////////////////////////////////////////
/// MOVE TO GENETAL PURPOSE REGISTER
            `mov:
	    begin
	        if(`mode)
		    gpr[`dst_reg]= `unsd;
		else
		    gpr[`dst_reg]=gpr[`src_reg1];
	    end


///////////////////////////////////////////////////////////////////////////////////////////////////
///ADDITION
            `add:
	    begin
	        if(`mode)
		    {tmp_cry,gpr[`dst_reg]}= gpr[`src_reg1]+`unsd;
		else
		    {tmp_cry,gpr[`dst_reg]}=gpr[`src_reg1]+gpr[`src_reg2];
	    end

/////////////////////////////////////////////////////////////////////////////////////////////////
///SUBTRACTION
            `sub:
	    begin
	        if(`mode)
		        gpr[`dst_reg]= gpr[`src_reg1]-`unsd;
		else
			gpr[`dst_reg]=gpr[`src_reg1]-gpr[`src_reg2];
	    end

///////////////////////////////////////////////////////////////////////////////////////////////////
////MULTIPLICATION
            `mul: 
	    begin
	        if(`mode)
		    mul_result= gpr[`src_reg1]*`unsd;
		else
		    mul_result=gpr[`src_reg1]* gpr[`src_reg2];
		
	        {sgpr,gpr[`dst_reg]}=mul_result;

	    end


//////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////LOGICAL OPERATIONS////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////
////OR
            `lor: 
	    begin
	        if(`mode)
	            gpr[`dst_reg]= gpr[`src_reg1] |`unsd;
		else
		    gpr[`dst_reg]=gpr[`src_reg1] | gpr[`src_reg2];
	    end


///////////////////////////////////////////////////////////////////////////////////////////////////
///AND
            `land:
	    begin
	        if(`mode)
		    gpr[`dst_reg]= gpr[`src_reg1] & `unsd;
	        else
		    gpr[`dst_reg]=gpr[`src_reg1] & gpr[`src_reg2];
	    end


///////////////////////////////////////////////////////////////////////////////////////////////////
///XOR
            `lxor:
	    begin
	        if(`mode)
		    gpr[`dst_reg]= gpr[`src_reg1]  ^ `unsd;
		else
		    gpr[`dst_reg]=gpr[`src_reg1] ^ gpr[`src_reg2];
	    end


///////////////////////////////////////////////////////////////////////////////////////////////////
//XNOR
            `lxnor:
	    begin
	        if(`mode)
		    gpr[`dst_reg]= gpr[`src_reg1] ~^ `unsd;
		else
		    gpr[`dst_reg]=gpr[`src_reg1] ~^ gpr[`src_reg2];
	    end


///////////////////////////////////////////////////////////////////////////////////////////////////
//NOR
            `lnor:
	    begin
	        if(`mode)
		    gpr[`dst_reg]= ~(gpr[`src_reg1] | `unsd);
		else
		    gpr[`dst_reg]=~(gpr[`src_reg1] | gpr[`src_reg2]);
 	    end


///////////////////////////////////////////////////////////////////////////////////////////////////
//NAND
            `lnand:
	    begin
	        if(`mode)
		    gpr[`dst_reg]= ~(gpr[`src_reg1] & `unsd);
		else
		    gpr[`dst_reg]= ~(gpr[`src_reg1] & gpr[`src_reg2]);
	    end


///////////////////////////////////////////////////////////////////////////////////////////////////
//NOT
            `lnot:
	    begin
	        if(`mode)
		    gpr[`dst_reg]= ~`unsd;
		else
	            gpr[`dst_reg]=~gpr[`src_reg1];
    	    end


///////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////DATA  MEMORY  TRANSACTION OPERATION////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////
////Databus to Data memory
            `ld_din_dtm:
            begin
                data_mem[`unsd]=din;
            end
	    
/////////////////////////////////////////////////////////////////////////////////////////////////
////register to data memory
            `ld_reg_dtm:
            begin
                data_mem[`unsd]=gpr[`src_reg1];
            end

/////////////////////////////////////////////////////////////////////////////////////////////////
//data memory to databus	
            `send_dtm_dout:
             begin
                dout=data_mem[`unsd];
             end

/////////////////////////////////////////////////////////////////////////////////////////////////
//data memory to register
            `send_dtm_reg:
            begin
                gpr[`dst_reg]=data_mem[`unsd];
            end

////////////////////////////////////////////////////////////////////////////////////////////////
//non-conditional jump	
            `jmp:
	    begin
	        jmp_flg =1;
            end

//////////////////////////////////////////////////////////////////////////////////////////////
//jump if carry
            `jcry:
	    begin
	    	if(cry) jmp_flg = 1; else jmp_flg=0;
       	    end
//////////////////////////////////////////////////////////////////////////////////////////////
//jump if no carry
            `jncry:
	    begin
		if(!cry) jmp_flg =1; else jmp_flg =0;
	    end

//////////////////////////////////////////////////////////////////////////////////////////////
//jump if sign 
            `jsgn:
	    begin
		if(sign) jmp_flg =1; else jmp_flg=0;
	    end

//////////////////////////////////////////////////////////////////////////////////////////////
//jump if no sign 
            `jnsgn:
	    begin
		if(!sign) jmp_flg=1; else jmp_flg=0;
	    end

//////////////////////////////////////////////////////////////////////////////////////////////
//jump if zero
            `jz:
	    begin
		if(zero) jmp_flg=1; else jmp_flg=0;
  	    end
//////////////////////////////////////////////////////////////////////////////////////////////
//jump if no zero
            `jnz:
	     begin
		if(!zero) jmp_flg=1; else jmp_flg=0;
   	    end
//////////////////////////////////////////////////////////////////////////////////////////////
//jump if overflow
            `jovf:
	    begin
		if(ov) jmp_flg=1; else jmp_flg=0;
	    end
//////////////////////////////////////////////////////////////////////////////////////////////
//jump if no overflow
            `jnovf:
 	    begin
		if(!ov) jmp_flg=1; else jmp_flg=0;
	    end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////HALT OPERATION///////////////////////////////////////	
            `hlt:
	    begin
		stop=1;
	    end

/////////////////////////////////////////////////////////////////////////////////////////////
	endcase
	
    end
    endtask



///////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////LOGIC FOR CONDITION FLAGS/////////////////////////////////////////////	
    task status_flag();
    begin

///////intialize cry flag to zero	    
        cry=0;

////////////////////////////////////////////////////////////////////////////////////////////////////////	
/////sign flag and zero flag        
	if (`op_code == `mul) 
	begin
	    sign =sgpr[15];                               
            zero = ~(|(gpr[`dst_reg] | sgpr));
	end		
	
	else
       	begin
	    sign = gpr[`dst_reg][15];
	    zero = ~(|gpr[`dst_reg]);
	end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////overflow flag for multiplication
	if (`op_code == `mul)
       	begin
   	    if (`mode ==0)
	        ov= (sgpr[15] && ~gpr[`src_reg1][15] && ~gpr[`src_reg2][15]) || (~sgpr[15] && gpr[`src_reg1][15] && gpr[`src_reg2][15]);
	    else
		ov=(sgpr[15] && ~gpr[`src_reg1][15] && ~(ir[15])) || (~sgpr[15] && gpr[`src_reg1][15] && ir[15]);
	end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////overflow and carry flag for addition
	else if (`op_code == `add)
       	begin
    	    if(`mode ==0)
	        ov=(gpr[`dst_reg][15] && ~gpr[`src_reg1][15] && ~gpr[`src_reg2][15]) || (gpr[`dst_reg][15]  && ~gpr[`src_reg1][15] && ~gpr[`src_reg2][15]) ;
	    else	
		ov=(gpr[`dst_reg][15] && ~gpr[`src_reg1][15] && ~ir[15]) || (gpr[`dst_reg][15]  && ~gpr[`src_reg1][15] && ~ir[15]) ;
			
	    cry=tmp_cry;
	end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
/////overflow flag for subtraction
	else if (`op_code == `sub)
       	begin
  	    if(`mode ==0)
	        ov=(gpr[`dst_reg][15] && ~gpr[`src_reg1][15] && gpr[`src_reg2][15]) || (~gpr[`dst_reg][15]  && gpr[`src_reg1][15] && ~gpr[`src_reg2][15]) ;
	    else
		ov=(gpr[`dst_reg][15] && ~gpr[`src_reg1][15] && ir[15]) || (~gpr[`dst_reg][15]  && gpr[`src_reg1][15] && ~ir[15]) ;
        end
    
    end
    endtask

        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////CONTROLLER PATH//////////////////////////////////////



reg [2:0] state,next_state;
parameter idle=3'b000,fetch=3'b001, decode_exec=3'b010,delay=3'b011,nxt_inst=3'b100, halt=3'b101;


always@(posedge clk)
    begin
        if(sys_rst)
	    begin PC=0;ir=0;state=idle; end
        else
	    begin state=next_state; end
    end


always@(state)
begin
    case(state)
	     idle:    begin next_state= fetch;   end

	     fetch:   begin next_state= decode_exec;  end

	     decode_exec: begin next_state= delay; end
	     
	     delay:   begin if (count<4) next_state= delay; else next_state= nxt_inst; end

	     nxt_inst: begin next_state=halt;     end

	     halt:    begin if(stop)  next_state = halt;    else if (sys_rst) next_state= idle; else next_state= idle;   end

	     default: begin next_state=idle;     end
    endcase
end


always@(state)
begin
    case(state)
	    idle: begin PC=0; ir=0;count=0; end

	    fetch: begin ir=pgm_mem[PC]; count=0;end

	    decode_exec:begin instrt_exec(); status_flag();count=0; end

	    delay: begin if(count<4) count= count+1 ;end
	    nxt_inst: begin count=0; if(jmp_flg) PC = `unsd; else PC=PC+1; end
	   
	    halt: begin count=0; end

	    default: begin count=0; ir =0; PC=0; end
    endcase
end

/*
///////////////////////////////////////////////////////////////////////
/////////////////////INSTRUCTION EXECUTION//////////////////////////////

    always@(posedge clk) 
    begin
       
        if (sys_rst) 
	begin
            ir<=0;
	    PC<=0;
	    
	end

        else 
	begin
	    if(count<4)
                count<=count+1;

	    else 
	    begin
	        ir=pgm_mem[PC];
	        
		instrt_exec();
		status_flag();
		PC=PC+1;
	        count=0;
	    end	

	end

    end
*/
endmodule

