package wck
{

    public class Box extends Shape
    {

        public function Box()
        {
            return;
        }// end function

        override public function addShapes(param1:Array) : void
        {
            param1.push(boxDef());
            super.addShapes(param1);
            return;
        }// end function

    }
}
