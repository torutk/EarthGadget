/*
 *  Copyright © 2018 toru
 */

module com.torutk.gadget.earth {
    requires java.prefs;
    requires javafx.controls;
    requires com.torutk.gadget.support;
    opens com.torutk.gadget.earth to javafx.graphics;
}
