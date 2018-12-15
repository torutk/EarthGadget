/*
 * Copyright © 2018 TAKAHASHI,Toru
 */

module com.torutk.gadget.earth {
    requires java.prefs;
    requires javafx.controls;
    requires com.torutk.gadget.support;
    opens com.torutk.gadget.earth to javafx.graphics;
}
