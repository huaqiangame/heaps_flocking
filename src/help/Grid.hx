package help;

import h3d.Vector;
import h2d.Object;
import h2d.Text;
import h2d.Graphics;
import h2d.Scene;

class Grid {
	/**
	 * Draws a Grid with variable width and height to the supplied Sprite Object.
	 * @param   numColumns      Number of columns in the
	 * @param   numRows         Number of rows in the
	 * @param   cellHeight      Cell height of the
	 * @param   cellWidth       Cell width of the
	 * @param   grid            Sprite Object that will be drawn to.
	 */
	public static function drawGrid(numColumns:Int, numRows:Int, cellHeight:Int, cellWidth:Int, graphics:h2d.Graphics):Void {
		graphics.clear();
		graphics.lineStyle(1, 0xEEE0E5, 0.2);

		// we drop in the " + 1 " so that it will cap the right and bottom sides.
		// for (var col:Number = 0; col < numColumns + 1; col++)
		for (col in 0...numColumns + 1) {
			// for (var row:Number = 0; row < numRows + 1; row++)
			for (row in 0...numRows + 1) {
				// trace(col, row);
				graphics.moveTo(col * cellWidth, 0);
				graphics.lineTo(col * cellWidth, cellHeight * numRows);
				graphics.moveTo(0, row * cellHeight);
				graphics.lineTo(cellWidth * numColumns, row * cellHeight);
			}
		}
	}

	public static function drawGridText(numColumns:Int, numRows:Int, cellHeight:Int, cellWidth:Int, object:Object):Void {
		// we drop in the " + 1 " so that it will cap the right and bottom sides.
		// for (var col:Number = 0; col < numColumns + 1; col++)
		var index = 0;

		// for (var row:Number = 0; row < numRows + 1; row++)
		for (row in 0...numRows ) {
			for (col in 0...numColumns + 1) {
				var text = new Text(hxd.res.DefaultFont.get(), object);
				text.text = index + "";
				text.y = row * cellHeight;
				text.x = col * cellWidth;
				text.color = new Vector();
				index++;
			}
		}
	}

	/**
	 * Draws a Grid with variable width and height to the supplied Sprite Object.
	 * @param   numColumns      Number of columns in the
	 * @param   numRows         Number of rows in the
	 * @param   cellHeight      Cell height of the
	 * @param   cellWidth       Cell width of the
	 * @param   grid            Sprite Object that will be drawn to.
	 */
	public static function drawGridWithBitMapdata(numColumns:Int, numRows:Int, cellHeight:Int, cellWidth:Int, graphics:hxd.BitmapData):Void {
		// we drop in the " + 1 " so that it will cap the right and bottom sides.
		// for (var col:Number = 0; col < numColumns + 1; col++)
		for (col in 0...numColumns + 1) {
			// for (var row:Number = 0; row < numRows + 1; row++)
			for (row in 0...numRows + 1) {
				// trace(col, row);
				//  graphics.moveTo(col * cellWidth, 0);
				// graphics.lineTo(col * cellWidth, cellHeight * numRows);
				// graphics.moveTo(0, row * cellHeight);
				// graphics.lineTo(cellWidth * numColumns, row * cellHeight);
				graphics.line(col * cellWidth, 0, col * cellWidth, cellHeight * numRows, 0xffffff);
				graphics.line(0, row * cellHeight, cellWidth * numColumns, row * cellHeight, 0xffffff);
			}
		}
	}
}
