#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#
#∞∞∞∞∞∞∞∞∞∞∞∞###summary###∞∞∞∞∞∞∞∞∞∞∞∞∞#
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#


def run_block1
  yield
end

run_block1 {puts "1. passed a default block using yield"}

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

def run_block2
  yield
end

proc_block = proc {puts "2. proc is converted to block with '&'; now that &proc_block is a block, method yields action to our disguised block as if it were a default block!"}
run_block2(&proc_block)

# the "&" converts our proc to a block since method was never expecting a proc argument but was yielding to a default block

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

def run_block3(&block)
  yield
  # block.call  # also works
end

run_block3 {puts "3. instead of implicitly yielding to a proc-converted-block, we're explicitly calling the 'proc' as a named parameter"}

def run_block3(block)
  # yield  # will not work - expecting a block, not a proc, during invocation
  block.call
end

run_block3 proc {puts "3b. parameter is an undefined proc, which you can deduce from seeing that the parameter gets called in the method body"}

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

def run_block4(undefined_proc_var)
  undefined_proc_var.call
end

run_block4 (proc {puts "4a. passed a proc with a named parameter"})
run_block4 (Proc.new {puts "4b. this is just another way to define a proc"})

procy = proc {puts "4c. this assigns the proc to a variable that gets passed as the argument - like the example below"}
run_block4(procy)

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

def run_block5(defined_proc_var)
  defined_proc_var.call
end
defined_proc_var = proc {puts "5. this proc references THIS block, points it to the defined_proc_var variable, then gets passed through the run_block5 method!"}
run_block5(defined_proc_var)

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

def run_block6
  p = Proc.new  # same as p = proc
  p.call
end

run_block6{puts "6. somewhere between yield, &proc, and proc is this - passes a block by referencing an undefined proc in the method's body; more similar to yield"}

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

def run_block7
  yield("defined", 100)
end

run_block7{|defined_parameter_word, defined_parameter_number| puts "7. passes an already '#{defined_parameter_word}' parameter through method that we can't change but can interpolate or manipulate if it were a number, like this: '#{defined_parameter_number + 1} is a not-so-freeway'."}

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#


def run_block8
  yield("parameter")
end

run_block8 {puts "8. defined parameter next to yield is optional"}
run_block8 {|para| puts "8.1. lets go ahead and call it here tho: '#{para}'"}

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

# to use an undefined parameter, method parameter name must be the same name as the undefined yield parameter; undefined parameter can be changed during invocation

def run_block9(undefined)
  yield("defined")
  yield(undefined)
  yield
end

run_block9("uh..undefined") {|yield_para| puts "9. parameter is #{yield_para}"}

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

def run_block10(para)
  para.call
  yield
end

run_block10(proc {puts "10. parameter is now a proc that's getting defined as I type it!"}) {puts "10.1. and this is the block next to proc that's getting called with yield."}

puts


#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#
#∞∞∞∞∞∞∞∞∞∞∞∞###summary###∞∞∞∞∞∞∞∞∞∞∞∞∞#
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#





puts
puts "***MORE EXAMPLES***"
puts
# Some more complex examples

### comment in the begin & =end if you want to hide this section ###

# =begin
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

def say_hi(name)
  puts "Hi, #{name}!"
  yield
end

say_hi("Steve") do
  puts "YOU'RE COOL!"
end

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

def say_hi(name)
  puts "Hi, #{name}!"
  if block_given?
    yield(name)
  end
end

say_hi("Steben") {|name| puts "#{name} is #{name.length} letters long."}

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

def say_hi(name)
  puts "Hi, #{name}!\n\n"
  yield(name, name.reverse) if block_given?
end

say_hi("Stefen") {|name, reversed_name| puts "This is pulling #{name} from first parameter next to yield. This is pulling #{reversed_name} from the second parameter. \n\nThis is pulling the first paramter and calling the reverse function during interpolation #{name.reverse}"}

## this block takes parameters (attached to yield)

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#
class Array
  def random_each  # this method attaches to the right of object/data structure since it's function is to call the method's shuffle and each on something
    shuffle.each do |el|
      yield el  # this yield is what allows us to give the method invocation of random_each a block
    end
  end
end

[1,2,3,4,5].random_each do |el|
  puts "#{el} - yielded blocks"
end

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#


class Array
  def random_each(&blockish)  # references code block run with method invocation, explicitly; this block reference is considered a proc; expects a block to be called when invoking this method!
    shuffle.each do |el|
      blockish.call el
    end
  end
end

[1,2,3,4,5].random_each do |el|
  puts "#{el} - called procs"
end

puts
##########CLOSURES##########

def run_proc(p)  # name variable isn't defined in body yet it still works because it's defined in the proc which then gets called by the method
  p.call
end

name = "Fred"
print_a_name = proc {puts name}
name = "John"  # doesn't store variable/values of closures, but only keeps reference; so content can be changed before proc runs
run_proc print_a_name

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

def multiple_generator(multiplier)
  lambda do |num|  # number is accepted during method invocation
    num * multiplier
  end
end

doubler = multiple_generator(2)
tripler = multiple_generator(3)

puts doubler[5]  #-->  10
puts tripler.call(10)  #-->  30

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

def gen_times(factor)
  proc {|n| n * factor}  # if proc has a parameter like this, you'll have to call the proc then pass an argument through that (proc.call(parameter))
end

times3 = gen_times(3)  # points the proc (the entire method) to a variable

times3.call(2)  # we now call the block per usual but pass it an argument to satisfy the proc's parameter

add1 = proc {|x| x + 1}
puts add1.call(1)

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

class Array
  def bubble_sort!(&prc)
    sorted = false
    until sorted
      sorted = true
      each_index do |idx|
        next if idx+1 == self.length
        if prc.call(self[idx], self[idx+1]) == 1
          sorted = false
          self[idx], self[idx+1] = self[idx+1], self[idx]
        end
      end
    end
    self
  end
end

arr = [1,3,2]
p arr.bubble_sort! {|num1, num2| num2 <=> num1}

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#


puts
puts "***REITERATION AND USES OF DIFFERENT PROCS***"
puts

# default block - defining a method that takes a block with no parameters

def run_block  # this is a method that accepts a block and yields action to block once method is called (just like map or each)
  yield if block_given?  # prevents error if no block is run with method invocation; only use this if you have a specific reason for it, otherwise, it's best to fail and fail early
end

run_block {puts "since definition yields, this method needs to have a block when run; like this one!"}

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

# yield with undefined parameters - yield's params must match method's params; unlike lambda, these parameters are optional and no argument has to be given during invocation

def call_block(name, num)
  puts "Start of method"
  yield(name, num) #??
  puts "End of the method"
end

call_block("Finn", 8) {puts "Inside the block"}
call_block("Jake", 8) {|name, num| puts "Inside the block #{name} #{num}"}

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

# yield with defined parameters - this allows you to interpolate yield's parameters and manipulate them if they're numbers, but you can't define your own arguments

def call_block
  puts "Start of method"
  yield("hello", 99)
  puts "End of the method"
end

call_block {puts "Inside the block"}
call_block {|name, num| puts "Inside the block #{name} #{num}"}

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

# passing yield through a method - just as you would an ordinary ol' block; the yield is essentially substituted for the block that you'd pass through the times method

def run_yield
  3.times {yield}  # in curly braces because p is a proc (also a block)
end

run_yield { puts "Hello World!" }

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

# essentially a yield with a &block_name (the & is what converts it to a proc); instead of yield, we define a proc variable as a parameter that we would then call in the method body; if called, we would then have to pass a block at the time of method invocation; this gives user control of defining their own block when calling method (like map or each!); procs can be passed as parameters but blocks can not - so, the & in the parameter converts the later defined block into a proc; this is technically not an parameter, it just notifies the method that a block will be run during invocation

def run_proc_3_times(&b)  # the advantage of this is the block is saved to proc for later use
  3.times {b.call}  # in curly braces because p is a proc (also a block)
end

run_proc_3_times { puts "Hello World!" }

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

# instead of a & b being data objects, they are procs (bits of code); even without clear parameter names, we know this by the "call" methods in the body; the method parameters are just variables for a proc, not proc name (just like str is arbitrary); difference between this and &proc is this one takes a user defined proc and runs its as an argument - no need to append a block during method invocation

def run_two_procs(a,b)
  a.call
  b.call
end

proc1 = Proc.new do
  puts "this is proc1"
end

proc2 = proc {puts "this is proc2"}  # different syntax of creating a proc

run_two_procs(proc1, proc2)

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

def run_proc(just_a_variable)
  just_a_variable.call  # since we're calling here, we know our variable is a proc
end

run_proc(proc {puts "No proc variable? No problem. We can simply set the proc that the method's parameter expects directly as the argument."})

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

# not quite yield, not quite a proc parameter, but somewhere in the middle.. this works because if Proc.new is created without a code block, it will use a code block passed during method invocation; like  yield, it needs a code block during invocation (that's what .call is trying to do and will fail if there is nothing to call)

def run_block
  p = Proc.new
  p.call
end

run_block do
  puts "Hello world"
end

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

# defining a proc that accepts a parameter means the method should (but doesn't have to) accept an argument during method invocation;

proc_with_para = proc do |optional_argument|  # try and get used to both syntax forms
  puts "This is a proc and regardless of number of parameters, attaching arguments during method invocation is#{optional_argument}.\n\n"
end

proc_with_para.call("optional")
proc_with_para.call

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

#defining a lambda that accepts parameters means the method MUST accept the same amount of argument during method invocation or it errors; **useless, but even if you define a paramter but never use it in the code block, you still need to pass the method an argument during invocation

lambda_with_para = lambda {|not_optional| puts "This is a lambda and the number of parameters have to match the number of arguments given during invocation - #{not_optional}! \n\n"}

lambda_with_para.call("not optional")
# lambda_with_para.call  # this will error out because wrong number of arguments given

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

# this p we know we want to reference a proc; by calling proc in body, we can either define a proc and assign it to a variable or just define block/lambda and append it after the method (essentially like a one time block, I believe)

def run_a_proc(para)
  puts "Starting to run a proc"
  para.call
  puts "Finished running the proc\n\n"
end


run_a_proc(lambda { puts "I'm a lambda"; return})  # () are optional for parameters and arguments
# run_a_proc(proc { puts "I'm a proc"; return })  # this errors because unexpected return


# this issue only occurs when we explicitly return;
#   -proc stops where it's defined (whether it's a proc variable defined after method or a proc created during method's invocation in the main context (you can't return stuff in the main context - you can only return in method bodies!)
#   -lambda stops where it is called (method body)
# the example above errors because it's attempting to return in the context body (where the proc is defined); this example stops where proc is defined, which happens to be within a method body, so it executes the return, but never continues the code where the proc was initially called (run_a_proc).. ya, pretty wild stuff..


#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#


def run_a_proc(p)
  puts "Starting to run a proc"
  p.call
  puts "Finished running the proc\n\n"
end

# lambda {puts "I'm a lambda"; return}

def our_program
  lam = lambda {puts "I'm a lambda"; return}
  run_a_proc(lam)  # remember, with proc parameters, you can either pass proc/lambda variable to a method when calling it or simply define it when calling method
  run_a_proc(proc {puts "I'm a proc"; return})  # () optional
end

our_program

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

# though arguments are optional with procs, this one would give an erorr without the proper argument, since it needs an argument to run the capitalize method on

capitalize_it = Proc.new do |word|
  word.capitalize
end

puts capitalize_it.call("howdy")

puts
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞#

say_hi = proc {puts "hi"}  # this is a variable pointing to a proc

def twice_do(action)  # this parameter will be taking in a proc since we're using .call in body
  action.call
  action.call
end

twice_do(say_hi)  # we can put say_hi here since it's a proc and the method is built to take a proc argument

# lets do this without putting the proc into a variable

twice_do(proc {puts "hi"})  # we can define the proc as we pass it to our method; we don't have to put procs in variables; all that needs to happen is the twice_do method has to take in a proc - so, a variable or writing it in is the same thing; proc gets passed in as a named parameter (because method parameter); this is vs a default block, that has no parameters and so, don't get refered to as anything, and gets passed as a normal block when invoking the method (yield calls on the block attached to method invocation; this is instead of parameter.call)

twice_do proc {puts "hi"}  # paranthesis are usually optional with parameter/arguments; just different syntax
