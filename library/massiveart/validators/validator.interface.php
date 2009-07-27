<?php
/**
 * Validator Interface
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-02-13: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.validators
 * @subpackage Validator
 */

interface Validator {

	/**
	 * @param     mixed $mixed anything to be validated.
	 * @return    mixed TRUE if valid, error message otherwise
	 * @author Thomas Schedler <tsh@massiveart.com>
 	 * @version 1.0
	 */
	public function isValid($mixed);
}

?>
