package wck
{

    public class Circle extends Shape
    {

        public function Circle()
        {
            return;
        }// end function

        override public function addShapes(param1:Array) : void
        {
            param1.push(circleDef());
            super.addShapes(param1);
            return;
        }// end function

    }
}
